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

class User < ApplicationRecord
  has_secure_password
  has_many :expenses, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
