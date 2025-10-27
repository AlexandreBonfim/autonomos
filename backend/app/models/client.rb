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

class Client < ApplicationRecord
  belongs_to :user, inverse_of: :clients
  has_many :invoices, dependent: :nullify, inverse_of: :client
end
