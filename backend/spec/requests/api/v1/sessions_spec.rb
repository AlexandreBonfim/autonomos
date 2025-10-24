# spec/requests/api/v1/sessions_spec.rb
require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'POST /api/v1/auth/signup' do
    it 'creates user and returns JWT' do
      post '/api/v1/auth/signup',
        params: { email: 'a@b.com', name: 'A', password: 'secret123', password_confirmation: 'secret123' }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('token')
    end
  end

  describe 'POST /api/v1/auth/login' do
    let!(:user) do
      User.create!(
        email: 'u@u.com', name: 'U',
        password: 'pw123456', password_confirmation: 'pw123456'
      )
    end

    it 'returns token with valid creds' do
      post '/api/v1/auth/login', params: { email: 'u@u.com', password: 'pw123456' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('token')
    end

    it '401 with invalid creds' do
      post '/api/v1/auth/login', params: { email: 'u@u.com', password: 'bad' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
