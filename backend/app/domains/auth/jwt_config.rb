module Auth
  module JWTConfig
    module_function

    def secret_key = ENV.fetch("JWT_SECRET") { Rails.application.credentials.jwt_secret || "dev-secret-change-me" }
    def algorithm = "HS256"
    def ttl = 24.hours
  end
end
