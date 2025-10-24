# spec/requests/api/v1/expenses_auth_spec.rb
require 'rails_helper'

RSpec.describe 'Expenses auth', type: :request do
  let!(:user) do
    User.create!(
      email: 'u@u.com', name: 'U',
      password: 'pw123456', password_confirmation: 'pw123456'
    )
  end

  it 'rejects without token' do
    get '/api/v1/expenses'
    expect(response).to have_http_status(:unauthorized)
  end

  it 'allows with token' do
    token = jwt_for(email: 'u@u.com', password: 'pw123456')
    get '/api/v1/expenses', headers: auth_header(token)
    expect(response).to have_http_status(:ok)
  end
end
