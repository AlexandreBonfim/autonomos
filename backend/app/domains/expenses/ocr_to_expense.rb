module Expenses
  class OcrToExpense
    # Maps parsed OCR payload into an Expense in 'pending' status
    def self.call(user, parsed)
      Expense.create!(
        user: user,
        description: "OCR: #{parsed[:supplier_name]}",
        total_cents: parsed[:total_amount_cents],
        currency: parsed[:currency] || 'EUR',
        iva_rate: parsed[:iva_rate],
        iva_amount_cents: parsed[:iva_amount_cents],
        irpf_rate: 0,
        irpf_withheld_cents: 0,
        deductible_percent: 100,
        issued_on: parsed[:issued_on],
        supplier_name: parsed[:supplier_name],
        supplier_tax_id: parsed[:supplier_tax_id],
        category: 'ocr',
        status: 'pending'
      )
    end
  end
end
