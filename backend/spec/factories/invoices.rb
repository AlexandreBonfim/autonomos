# == Schema Information
#
# Table name: invoices
#
#  id                  :integer          not null, primary key
#  user_id             :integer          not null
#  client_id           :integer          not null
#  number              :string
#  series              :string
#  issued_on           :date
#  due_on              :date
#  currency            :string
#  subtotal_cents      :integer
#  iva_rate            :decimal(5, 2)
#  iva_amount_cents    :integer
#  irpf_rate           :decimal(5, 2)
#  irpf_withheld_cents :integer
#  total_cents         :integer
#  status              :string
#  notes               :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  idx_invoices_unique_per_series  (user_id,series,number,issued_on) UNIQUE
#  index_invoices_on_client_id     (client_id)
#  index_invoices_on_number        (number)
#  index_invoices_on_user_id       (user_id)
#

FactoryBot.define do
  factory :invoice do
    user { nil }
    client { nil }
    number { "MyString" }
    series { "MyString" }
    issued_on { "2025-10-24" }
    due_on { "2025-10-24" }
    currency { "MyString" }
    subtotal_cents { 1 }
    iva_rate { "9.99" }
    iva_amount_cents { 1 }
    irpf_rate { "9.99" }
    irpf_withheld_cents { 1 }
    total_cents { 1 }
    status { "MyString" }
    notes { "MyText" }
  end
end
