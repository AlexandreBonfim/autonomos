require 'rails_helper'

RSpec.describe "API::V1::Tax::Summaries", type: :request do
  let!(:user)   { User.create!(email: 'tax@u.com', name: 'Tax', password: 'pw123456', password_confirmation: 'pw123456') }
  let!(:client) { Client.create!(user: user, name: 'ACME', email: 'c@acme', tax_id: 'B123') }

  def token
    post '/api/v1/auth/login', params: { email: 'tax@u.com', password: 'pw123456' }
    JSON.parse(response.body)['token']
  end

  before do
    # Q4 2025 sample data:
    # Invoice 227.00 (100 base @21% + 2*50 @21%, with 15% IRPF on first line → irpf 15 on 100 base)
    user.invoices.create!(
      client: client, number: '2025-0003', series: 'A', issued_on: Date.new(2025,10,21), currency: 'EUR',
      invoice_items_attributes: [
        { description: 'Serv', quantity: 1, unit_price_cents: 100_00, discount_cents: 0, iva_rate: 21, irpf_rate: 15 },
        { description: 'Mant', quantity: 2, unit_price_cents:  50_00, discount_cents: 0, iva_rate: 21, irpf_rate: 0 }
      ]
    )
    # Expense 121.00 (21 IVA)
    user.expenses.create!(
      description: 'Super', total_cents: 121_00, iva_amount_cents: 21_00,
      currency: 'EUR', deductible_percent: 100, issued_on: Date.new(2025,10,20)
    )
  end

  it 'returns quarter summary' do
    get '/api/v1/tax/periods/2025/q/4', headers: { 'Authorization' => "Bearer #{token}" }
    
    expect(response).to have_http_status(:ok)

    json = JSON.parse(response.body)

    # Invoices
    expect(json.dig('invoices','base_cents')).to eq(200_00)
    expect(json.dig('invoices','iva_repercutido_cents')).to eq(42_00)
    expect(json.dig('invoices','irpf_retenido_cents')).to eq(15_00)
    # Expenses
    expect(json.dig('expenses','base_cents')).to eq(100_00)
    expect(json.dig('expenses','iva_soportado_cents')).to eq(21_00)
    # Totals
    expect(json.dig('totals','iva_net_to_pay_cents')).to eq(21_00)  # 42 - 21
  end

  it 'returns month summary' do
    get '/api/v1/tax/periods/2025/m/10', headers: { 'Authorization' => "Bearer #{token}" }
    
    expect(response).to have_http_status(:ok)
    
    json = JSON.parse(response.body)
    
    expect(json.dig('counts','invoices')).to eq(1)
    expect(json.dig('counts','expenses')).to eq(1)
  end
end
