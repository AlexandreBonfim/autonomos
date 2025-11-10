FactoryBot.define do
  factory :invoice_sequence do
    user { nil }
    series { "MyString" }
    year { 1 }
    last_number { 1 }
  end
end
