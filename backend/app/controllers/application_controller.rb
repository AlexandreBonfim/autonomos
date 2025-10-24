class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate!
    result = Auth::Authenticate.call(request.headers["Authorization"])
    if result.ok?
      @current_user = result.user
    else
      render json: { error: auth_error_message(result.error) }, status: :unauthorized
    end
  end

  def auth_error_message(code)
    {
      missing_header: "Authorization header missing",
      bad_scheme: "Authorization scheme must be Bearer",
      invalid_token: "Invalid token",
      expired: "Token expired",
      user_not_found: "User not found"
    }[code] || "Unauthorized"
  end
end
