# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string
#  name               :string
#  encrypted_password :string
#  tax_id             :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email   (email)
#  index_users_on_tax_id  (tax_id)
#

class User < ApplicationRecord
  has_many :expenses, dependent: :destroy
end
