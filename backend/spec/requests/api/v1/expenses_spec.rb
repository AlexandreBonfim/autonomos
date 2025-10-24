require 'rails_helper'

RSpec.describe "API::V1::Expenses", type: :request do
  let!(:user) { User.create!(email: 'u@u', name: 'U') }

  it 'lists expenses' do
    user.expenses.create!(description: 'Ticket', total_cents: 121_00, iva_amount_cents: 21_00,
                          currency: 'EUR', deductible_percent: 100, issued_on: Date.today)
    get '/api/v1/expenses'
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).size).to eq(1)
  end
end
