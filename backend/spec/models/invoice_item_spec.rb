# == Schema Information
#
# Table name: invoice_items
#
#  id               :integer          not null, primary key
#  invoice_id       :integer          not null
#  description      :string
#  quantity         :integer
#  unit_price_cents :integer
#  discount_cents   :integer
#  iva_rate         :decimal(5, 2)
#  irpf_rate        :decimal(5, 2)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_invoice_items_on_invoice_id  (invoice_id)
#

require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
