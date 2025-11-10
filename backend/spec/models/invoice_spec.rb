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

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
