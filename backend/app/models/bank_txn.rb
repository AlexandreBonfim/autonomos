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

class BankTxn < ApplicationRecord
  belongs_to :user

  enum status: { unreconciled: 'unreconciled', reconciled: 'reconciled' }

  validates :occurred_on, :amount_cents, :currency, :description, presence: true
  validates :amount_cents, numericality: { other_than: 0 }
end
