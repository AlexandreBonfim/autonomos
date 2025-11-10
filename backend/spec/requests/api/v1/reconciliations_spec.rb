require 'rails_helper'

RSpec.describe "API::V1::Reconciliations", type: :request do
  let!(:user) { User.create!(email: 'rec@u.com', name: 'Rec', password: 'pw123456', password_confirmation: 'pw123456') }
  let!(:client) { Client.create!(user: user, name: 'ACME', email: 'c@acme', tax_id: 'B123') }

  def token
    post '/api/v1/auth/login', params: { email: 'rec@u.com', password: 'pw123456' }
    JSON.parse(response.body)['token']
  end

  it 'creates a reconciliation between a bank txn and an expense' do
    exp = user.expenses.create!(description: 'Ticket', total_cents: 121_00, iva_amount_cents: 21_00,
                                currency: 'EUR', deductible_percent: 100, issued_on: Date.new(2025,10,20))

    txn = user.bank_txns.create!(occurred_on: Date.new(2025,10,20), amount_cents: -121_00,
                                 currency: 'EUR', description: 'Supermercado', status: 'unreconciled')

    post '/api/v1/reconciliations',
      params: { bank_txn_id: txn.id, matchable_type: 'Expense', matchable_id: exp.id, matched_amount: 121.0 },
      headers: { 'Authorization' => "Bearer #{token}" }

    expect(response).to have_http_status(:created)
    expect(user.reconciliations.count).to eq(1)
    expect(txn.reload.status).to eq('reconciled')
  end
end
