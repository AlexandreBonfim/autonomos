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

FactoryBot.define do
  factory :expense do
    user { nil }
    description { "MyString" }
    total_cents { 1 }
    currency { "MyString" }
    iva_rate { "9.99" }
    iva_amount_cents { 1 }
    irpf_rate { "9.99" }
    irpf_withheld_cents { 1 }
    deductible_percent { "9.99" }
    issued_on { "2025-10-24" }
    supplier_name { "MyString" }
    supplier_tax_id { "MyString" }
    document_id { 1 }
    category { "MyString" }
    status { "MyString" }
  end
end
