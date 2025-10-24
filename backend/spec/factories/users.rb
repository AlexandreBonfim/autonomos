# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  name            :string
#  tax_id          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#
# Indexes
#
#  index_users_on_email   (email)
#  index_users_on_tax_id  (tax_id)
#

FactoryBot.define do
  factory :user do
    email { "MyString" }
    name { "MyString" }
    encrypted_password { "MyString" }
    tax_id { "MyString" }
  end
end
