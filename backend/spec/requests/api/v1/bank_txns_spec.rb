require 'rails_helper'

RSpec.describe "API::V1::BankTxns", type: :request do
  let!(:user) { User.create!(email: 'bank@u.com', name: 'Bank', password: 'pw123456', password_confirmation: 'pw123456') }
  let!(:client) { Client.create!(user: user, name: 'ACME', email: 'c@acme', tax_id: 'B123') }

  def token
    post '/api/v1/auth/login', params: { email: 'bank@u.com', password: 'pw123456' }
    JSON.parse(response.body)['token']
  end

  it 'imports CSV into bank_txns' do
    csv = <<~CSV
      date,description,amount,currency,external_id
      2025-10-20,Supermercado,-121.00,EUR,tx-1
      2025-10-21,Cliente ACME,+227.00,EUR,tx-2
    CSV
    post '/api/v1/bank_txns/import_csv', params: { csv: csv }, headers: { 'Authorization' => "Bearer #{token}" }
    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)['imported']).to eq(2)
    expect(user.bank_txns.count).to eq(2)
  end

  it 'suggests candidates for an outgoing expense' do
    # Create matching expense: 121.00 on 2025-10-20
    user.expenses.create!(
      description: 'Ticket', total_cents: 121_00, iva_amount_cents: 21_00,
      currency: 'EUR', deductible_percent: 100, issued_on: Date.new(2025,10,20)
    )
    # Import txn
    csv = "date,description,amount,currency\n2025-10-20,Supermercado,-121.00,EUR\n"
    post '/api/v1/bank_txns/import_csv', params: { csv: csv }, headers: { 'Authorization' => "Bearer #{token}" }
    txn = user.bank_txns.last

    get "/api/v1/bank_txns/#{txn.id}/candidates", headers: { 'Authorization' => "Bearer #{token}" }
    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body['type']).to eq('expense')
    expect(body['candidates'].first&.dig('total_cents')).to eq(121_00)
  end
end
