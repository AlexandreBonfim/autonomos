module AuthHelpers
  def jwt_for(email:, password:)
    user = User.find_by(email: email)
    return nil unless user&.authenticate(password)

    Auth::IssueToken.call(user)
  end

  def auth_header(token)
    { 'Authorization' => "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request
end
