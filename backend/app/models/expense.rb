# == Schema Information
#
# Table name: expenses
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  description         :string
#  total_cents         :integer
#  currency            :string
#  iva_rate            :decimal(5, 2)
#  iva_amount_cents    :integer
#  irpf_rate           :decimal(5, 2)
#  irpf_withheld_cents :integer
#  deductible_percent  :decimal(5, 2)
#  issued_on           :date
#  supplier_name       :string
#  supplier_tax_id     :string
#  document_id         :integer
#  category            :string
#  status              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_expenses_on_document_id  (document_id)
#  index_expenses_on_user_id      (user_id)
#

class Expense < ApplicationRecord
  belongs_to :user
  validates :currency, :issued_on, presence: true
  enum status: { pending: "pending", reconciled: "reconciled" }, _default: "pending" # make a const file later

  def net_base_cents
    total_cents - iva_amount_cents + irpf_withheld_cents
  end

  def deductible_cents
    (net_base_cents * (deductible_percent.to_d / 100)).to_i
  end
end
