module Billing
  class InvoiceCalculator
    Result = Struct.new(:subtotal_cents, :iva_amount_cents, :irpf_withheld_cents, :total_cents, keyword_init: true)

    def self.call(invoice)
      subtotal = 0
      iva_sum  = 0
      irpf_sum = 0

      invoice.invoice_items.each do |line|
        base = line.base_cents
        
        next if base <= 0
        
        subtotal += base
        iva_sum  += (base * BigDecimal(line.iva_rate.to_s)  / 100).to_i
        irpf_sum += (base * BigDecimal(line.irpf_rate.to_s) / 100).to_i
      end

      total = subtotal + iva_sum - irpf_sum
      
      Result.new(subtotal_cents: subtotal, iva_amount_cents: iva_sum, irpf_withheld_cents: irpf_sum, total_cents: total)
    end
  end
end
