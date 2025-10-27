module Domains
  module Ocr
    class SimpleParser
      # Very naive parser that expects metadata['mock_ocr_text']
      # Example lines:
      # Supplier: Mercadona S.A. | CIF: B12345678
      # Date: 2025-10-21
      # Base: 100.00 | IVA%: 21 | IVA: 21.00 | Total: 121.00
      def self.call(doc)
        text = (doc.metadata || {})['mock_ocr_text'].to_s

        supplier_name  = text[/Supplier:\s*(.+?)\s*\|/i, 1] || text[/Proveedor:\s*(.+?)\s*\|/i, 1]
        supplier_tax_id = text[/CIF:\s*([A-Z0-9]+)/i, 1] || text[/NIF:\s*([A-Z0-9]+)/i, 1]
        issued_on      = text[/Date:\s*([0-9\-\/]+)/i, 1] || text[/Fecha:\s*([0-9\-\/]+)/i, 1]
        base           = text[/Base:\s*([0-9\.,]+)/i, 1]
        iva_rate       = text[/IVA%:\s*([0-9\.,]+)/i, 1]
        iva_amount     = text[/IVA:\s*([0-9\.,]+)/i, 1]
        total          = text[/Total:\s*([0-9\.,]+)/i, 1]

        {
          supplier_name: supplier_name&.strip,
          supplier_tax_id: supplier_tax_id&.strip,
          issued_on: issued_on ? Date.parse(issued_on) : nil,
          base_amount_cents: to_cents(base),
          iva_rate: to_d(iva_rate),
          iva_amount_cents: to_cents(iva_amount),
          total_amount_cents: to_cents(total),
          currency: 'EUR'
        }.compact
      end

      def self.to_cents(s)
        return nil if s.nil?
        (s.tr('.', '').tr(',', '.').to_f * 100).round
      end

      def self.to_d(s)
        return nil if s.nil?
        BigDecimal(s.tr(',', '.'))
      end
    end
  end
end
