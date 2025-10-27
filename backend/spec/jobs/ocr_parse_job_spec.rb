require 'rails_helper'

RSpec.describe OcrParseJob, type: :job do
  it 'parses document and creates an Expense draft' do
    user = User.create!(email: 'ocr@u.com', name: 'OCR', password: 'pw123456', password_confirmation: 'pw123456')
    doc = user.documents.create!(
      kind: 'expense_ticket',
      original_filename: 'ticket.jpg',
      content_type: 'image/jpeg',
      size_bytes: 111,
      metadata: { mock_ocr_text: "Supplier: Mercadona S.A. | CIF: B12345678\nDate: 2025-10-21\nBase: 100,00 | IVA%: 21 | IVA: 21,00 | Total: 121,00" },
      status: :uploaded
    )

    perform_enqueued_jobs do
      OcrParseJob.perform_later(doc.id)
    end

    doc.reload
    
    expect(doc.status).to eq('parsed')

    exp = user.expenses.order(created_at: :desc).first

    expect(exp).to be_present
    expect(exp.description).to include('Mercadona')
    expect(exp.total_cents).to eq(121_00)
    expect(exp.iva_amount_cents).to eq(21_00)
    expect(exp.issued_on).to eq(Date.new(2025,10,21))
    expect(exp.status).to eq('pending')
  end
end
