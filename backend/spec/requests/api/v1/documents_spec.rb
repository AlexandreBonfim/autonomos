require 'rails_helper'

RSpec.describe "API::V1::Documents", type: :request do
  let!(:user) { User.create!(email: 'doc@u.com', name: 'Doc', password: 'pw123456', password_confirmation: 'pw123456') }

  it 'creates a document and enqueues OCR job' do
    # login
    post '/api/v1/auth/login', params: { email: 'doc@u.com', password: 'pw123456' }
    token = JSON.parse(response.body)['token']

    payload = {
      document: {
        kind: 'expense_ticket',
        original_filename: 'mercadona.jpg',
        content_type: 'image/jpeg',
        size_bytes: 123456,
        metadata: {
          mock_ocr_text: "Supplier: Mercadona S.A. | CIF: B12345678\nDate: 2025-10-21\nBase: 100,00 | IVA%: 21 | IVA: 21,00 | Total: 121,00"
        }
      }
    }

    expect {
      post '/api/v1/documents', params: payload, headers: { 'Authorization' => "Bearer #{token}" }
    }.to have_enqueued_job(OcrParseJob)

    expect(response).to have_http_status(:created)
    json = JSON.parse(response.body)
    expect(json['status']).to eq('uploaded')
  end
end
