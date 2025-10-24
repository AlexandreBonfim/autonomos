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

class TaxProfile < ApplicationRecord
  belongs_to :user
end
