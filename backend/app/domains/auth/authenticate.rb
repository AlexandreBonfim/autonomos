require_relative "jwt_config"

module Auth
  class Authenticate
    Result = Struct.new(:ok?, :user, :error, keyword_init: true)

    def self.call(authorization_header)
      return Result.new(ok?: false, error: :missing_header) if authorization_header.blank?

      scheme, token = authorization_header.split(" ", 2)

      return Result.new(ok?: false, error: :bad_scheme) unless scheme&.casecmp("Bearer")&.zero?

      decoded = JWT.decode(token, Auth::JWTConfig.secret_key, true, { algorithm: Auth::JWTConfig.algorithm })
      payload = decoded.first
      user = User.find_by(id: payload["sub"], email: payload["email"])

      return Result.new(ok?: false, error: :user_not_found) unless user

      Result.new(ok?: true, user: user)
    rescue JWT::ExpiredSignature
      Result.new(ok?: false, error: :expired)
    rescue JWT::DecodeError
      Result.new(ok?: false, error: :invalid_token)
    end
  end
end
