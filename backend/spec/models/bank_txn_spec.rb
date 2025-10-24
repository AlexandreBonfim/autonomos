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

require 'rails_helper'

RSpec.describe BankTxn, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
