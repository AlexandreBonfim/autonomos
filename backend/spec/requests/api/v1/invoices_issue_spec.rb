require 'rails_helper'

RSpec.describe "API::V1::Invoices issue", type: :request do
  let!(:user)   { User.create!(email: 'i@u.com', name: 'I', password: 'pw123456', password_confirmation: 'pw123456') }
  let!(:client) { Client.create!(user: user, name: 'ACME', email: 'c@acme', tax_id: 'B123') }

  def token
    post '/api/v1/auth/login', params: { email: 'i@u.com', password: 'pw123456' }
    JSON.parse(response.body)['token']
  end

  it 'assigns a number and locks the invoice' do
    inv = user.invoices.create!(
      client: client, series: 'A', number: nil, issued_on: Date.new(2025,10,21), currency: 'EUR',
      invoice_items_attributes: [
        { description: 'Serv', quantity: 1, unit_price_cents: 100_00, iva_rate: 21, irpf_rate: 15, discount_cents: 0 }
      ]
    )

    post "/api/v1/invoices/#{inv.id}/issue", headers: { 'Authorization' => "Bearer #{token}" }
    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body['status']).to eq('issued')
    expect(body['number']).to match(/^A-2025-\d{4}$/)

    # try to change totals after issue
    patch "/api/v1/invoices/#{inv.id}", params: {
      invoice: { notes: "ok", invoice_items_attributes: [{ id: inv.invoice_items.first.id, unit_price_cents: 50_00 }] }
    }, headers: { 'Authorization' => "Bearer #{token}" }
    expect(response).to have_http_status(:unprocessable_entity)
    expect(JSON.parse(response.body)['errors'].join).to match(/cannot be modified/i)
  end

  it 'increments the sequence per series and year' do
    2.times do
      inv = user.invoices.create!(
        client: client, series: 'A', issued_on: Date.new(2025,10,22), currency: 'EUR',
        invoice_items_attributes: [{ description: 'Line', quantity: 1, unit_price_cents: 10_00, iva_rate: 21, irpf_rate: 0, discount_cents: 0 }]
      )
      post "/api/v1/invoices/#{inv.id}/issue", headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
    end
    nums = user.invoices.order(:id).pluck(:number).compact
    expect(nums.last).to end_with("0002")
  end
end
