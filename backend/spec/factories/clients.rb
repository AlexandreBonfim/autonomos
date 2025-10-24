# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  name            :string
#  email           :string
#  tax_id          :string
#  billing_address :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_clients_on_user_id  (user_id)
#

FactoryBot.define do
  factory :client do
    user { nil }
    name { "MyString" }
    email { "MyString" }
    tax_id { "MyString" }
    billing_address { "MyText" }
  end
end
