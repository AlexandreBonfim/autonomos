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

  validates :email, presence: true, uniqueness: true

  has_many :clients,        dependent: :destroy, inverse_of: :user
  has_many :invoices,       dependent: :destroy, inverse_of: :user
  has_many :expenses,       dependent: :destroy, inverse_of: :user
  has_many :documents,      dependent: :destroy, inverse_of: :user
  has_many :bank_txns,      dependent: :destroy, inverse_of: :user
  has_many :reconciliations,dependent: :destroy, inverse_of: :user
end
