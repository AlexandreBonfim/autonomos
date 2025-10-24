require_relative "jwt_config"

module Auth
  class IssueToken
    def self.call(user)
      payload = {
        sub: user.id,
        email: user.email,
        iat: Time.now.to_i,
        exp: (Time.now + Auth::JWTConfig.ttl).to_i
      }

      JWT.encode(payload, Auth::JWTConfig.secret_key, Auth::JWTConfig.algorithm)
    end
  end
end
