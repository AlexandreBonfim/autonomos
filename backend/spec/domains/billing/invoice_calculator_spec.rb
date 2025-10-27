require 'rails_helper'

RSpec.describe Billing::InvoiceCalculator do
  it 'computes per-line IVA and IRPF' do
    user = User.create!(email: 'x@x', name: 'X', password: 'pw123456', password_confirmation: 'pw123456')
    client = Client.create!(user: user, name: 'C', email: 'c@c', tax_id: 'B')
    invoice = Invoice.new(user: user, client: client, number: '1', series: 'A', issued_on: Date.today, currency: 'EUR')
    invoice.invoice_items.build(description: 'L1', quantity: 1, unit_price_cents: 100_00, discount_cents: 0, iva_rate: 21, irpf_rate: 15)
    invoice.invoice_items.build(description: 'L2', quantity: 2, unit_price_cents:  50_00, discount_cents: 0, iva_rate: 21, irpf_rate: 0)

    out = described_class.call(invoice)
    puts "out: #{out}"
    expect(out.subtotal_cents).to eq(200_00)
    expect(out.iva_amount_cents).to eq(42_00)
    expect(out.irpf_withheld_cents).to eq(15_00)
    expect(out.total_cents).to eq(227_00)
  end
end
