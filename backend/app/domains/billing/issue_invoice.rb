module Billing
  class IssueInvoice
    class Error < StandardError; end

    def self.call(invoice)
      raise Error, "Only draft invoices can be issued" unless invoice.draft?
      raise Error, "Series required" if invoice.series.blank?
      raise Error, "Issued on required" if invoice.issued_on.blank?

      year = invoice.issued_on.year

      ActiveRecord::Base.transaction do
        seq = InvoiceSequence.lock.find_or_create_by!(user: invoice.user, series: invoice.series, year: year)
        next_number = seq.last_number.to_i + 1
        # Assign and persist
        invoice.number = format_number(next_number, year: year, series: invoice.series)
        invoice.status = :issued
        invoice.save!

        seq.update!(last_number: next_number)
      end

      invoice
    rescue ActiveRecord::RecordInvalid => e
      raise Error, e.record.errors.full_messages.to_sentence
    end

    def self.format_number(n, year:, series:)
      # e.g. "A-2025-0001"
      "#{series}-#{year}-#{n.to_s.rjust(4, '0')}"
    end
  end
end
