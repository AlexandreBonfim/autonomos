FactoryBot.define do
  factory :bank_txn do
    user { nil }
    external_id { "MyString" }
    occurred_on { "2025-10-24" }
    amount_cents { 1 }
    currency { "MyString" }
    description { "MyString" }
    raw_payload { "" }
    source { "MyString" }
    status { "MyString" }
  end
end
