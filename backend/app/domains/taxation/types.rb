module Taxation
  module Types
    include Dry.Types()

    MoneyCents  = Types::Integer.constrained(gteq: 0)
    Rate        = Types::Decimal.constrained(gteq: 0, lteq: 100)
  end
end
