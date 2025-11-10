require 'csv'

module Banking
  class CsvImporter
    # Expects CSV headers: date, description, amount, currency, external_id (optional)
    # amount can be "+123.45" or "-123,45"
    def self.call(user:, io:, source: 'csv')
      created = 0
      CSV.new(io, headers: true).each do |row|
        occurred_on = Date.parse(row['date'].to_s)
        amount_cents = to_cents(row['amount'])
        currency = (row['currency'] || 'EUR').upcase
        ext_id = row['external_id'].presence
        attrs = {
          user: user,
          occurred_on: occurred_on,
          amount_cents: amount_cents,
          currency: currency,
          description: row['description'],
          raw_payload: row.to_h,
          source: source,
          status: 'unreconciled',
          external_id: ext_id
        }
        # idempotency on external_id + user (if provided)
        if ext_id.present?
          BankTxn.find_or_create_by!(user: user, external_id: ext_id) do |t|
            t.assign_attributes(attrs.except(:user, :external_id))
          end
        else
          BankTxn.create!(attrs)
        end
        created += 1
      end
      created
    end

    def self.to_cents(s)
      # Accepts formats like "+123.45" or "-123,45"
      # Normalize: remove "+" signs, convert comma decimals to dot, keep the minus if present
      normalized = s.to_s.strip.tr('+', '').tr(',', '.')
      (normalized.to_f * 100).round
    end
  end
end
