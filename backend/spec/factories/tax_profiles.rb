# == Schema Information
#
# Table name: tax_profiles
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  name              :string
#  default_iva_rate  :decimal(5, 2)
#  default_irpf_rate :decimal(5, 2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_tax_profiles_on_user_id  (user_id)
#

FactoryBot.define do
  factory :tax_profile do
    user { nil }
    name { "MyString" }
    default_iva_rate { "9.99" }
    default_irpf_rate { "9.99" }
  end
end
