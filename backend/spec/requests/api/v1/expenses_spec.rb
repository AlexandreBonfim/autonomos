# spec/requests/api/v1/expenses_spec.rb
require 'rails_helper'

RSpec.describe "API::V1::Expenses", type: :request do
  let!(:user) do
    User.create!(
      email: 'u@u', name: 'U',
      password: 'pw123456', password_confirmation: 'pw123456'
    )
  end

  it 'lists expenses' do
    user.expenses.create!(
      description: 'Ticket', total_cents: 121_00, iva_amount_cents: 21_00,
      currency: 'EUR', deductible_percent: 100, issued_on: Date.today
    )

    token = jwt_for(email: 'u@u', password: 'pw123456')
    get '/api/v1/expenses', headers: auth_header(token)

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).size).to eq(1)
  end
end
