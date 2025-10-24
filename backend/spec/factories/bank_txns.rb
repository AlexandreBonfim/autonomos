# == Schema Information
#
# Table name: bank_txns
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  external_id  :string
#  occurred_on  :date
#  amount_cents :integer
#  currency     :string
#  description  :string
#  raw_payload  :jsonb
#  source       :string
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_bank_txns_on_external_id  (external_id)
#  index_bank_txns_on_user_id      (user_id)
#

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
