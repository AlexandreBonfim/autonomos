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

require 'rails_helper'

RSpec.describe Expense, type: :model do
  it 'returns net base and deductible amount' do
    exp = described_class.new(
      total_cents: 121_00,
      currency: 'EUR',
      iva_amount_cents: 21_00,
      irpf_withheld_cents: 0,
      deductible_percent: 100,
      issued_on: Date.today
    )

    expect(exp.net_base_cents).to eq(100_00)
    expect(exp.deductible_cents).to eq(100_00)
  end
end
