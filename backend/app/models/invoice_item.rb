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

# app/models/invoice_item.rb
class InvoiceItem < ApplicationRecord
  belongs_to :invoice

  before_validation :defaults

  validates :description, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :discount_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :iva_rate, :irpf_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  def base_cents
    (quantity * unit_price_cents) - discount_cents
  end

  private

  def defaults
    self.quantity ||= 1
    self.discount_cents ||= 0
    self.iva_rate = 0 if iva_rate.nil?
    self.irpf_rate = 0 if irpf_rate.nil?
  end
end
