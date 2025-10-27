require 'rails_helper'

RSpec.describe "API::V1::Invoices", type: :request do
  let!(:user) do
    User.create!(email: 'bill@u.com', name: 'Bill',
                 password: 'pw123456', password_confirmation: 'pw123456')
  end
  let!(:client) { Client.create!(user: user, name: 'ACME', email: 'c@acme', tax_id: 'B123') }

  it 'creates an invoice with items and computes totals' do
    post '/api/v1/auth/login', params: { email: 'bill@u.com', password: 'pw123456' }

    token = JSON.parse(response.body)['token']
    payload = {
      invoice: {
        client_id: client.id,
        number: '2025-0001',
        series: 'A',
        issued_on: Date.today,
        currency: 'EUR',
        invoice_items_attributes: [
          { description: 'Servicio desarrollo', quantity: 1, unit_price_cents: 100_00, discount_cents: 0, iva_rate: 21, irpf_rate: 15 },
          { description: 'Mantenimiento',       quantity: 2, unit_price_cents:  50_00, discount_cents: 0, iva_rate: 21, irpf_rate: 0 }
        ]
      }
    }

    post '/api/v1/invoices', params: payload, headers: { 'Authorization' => "Bearer #{token}" }
    expect(response).to have_http_status(:created)

    json = JSON.parse(response.body)

    expect(json.dig('totals','subtotal_cents')).to eq(200_00)   # 100 + (2*50)
    expect(json.dig('totals','iva_amount_cents')).to eq(42_00)  # 21% of 200
    expect(json.dig('totals','irpf_withheld_cents')).to eq(15_00) # 15% of 100
    expect(json.dig('totals','total_cents')).to eq(227_00)      # 200 + 42 - 15
    expect(json['items'].size).to eq(2)
  end

  it 'shows the invoice' do
    token = post('/api/v1/auth/login', params: { email: 'bill@u.com', password: 'pw123456' }).then { JSON.parse(response.body)['token'] }
    inv = user.invoices.create!(
      client: client, number: '2025-0002', series: 'A', issued_on: Date.today, currency: 'EUR',
      invoice_items_attributes: [
        { description: 'Linea', quantity: 1, unit_price_cents: 10_00, discount_cents: 0, iva_rate: 21, irpf_rate: 0 }
      ]
    )

    get "/api/v1/invoices/#{inv.id}", headers: { 'Authorization' => "Bearer #{token}" }
    
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).dig('totals','total_cents')).to eq(12_10)
  end
end
