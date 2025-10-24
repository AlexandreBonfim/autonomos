module Auth
  class IssueToken
    def self.call(user)
      payload = {
        sub: user.id,
        email: user.email,
        iat: Time.now.to_i,
        exp: (Time.now + JWTConfig.ttl).to_i
      }

      JWT.encode(payload, JWTConfig.secret_key, JWTConfig.algorithm)
    end
  end
end
