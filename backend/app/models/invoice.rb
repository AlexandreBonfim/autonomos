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
#  index_invoices_on_client_id  (client_id)
#  index_invoices_on_number     (number)
#  index_invoices_on_user_id    (user_id)
#

class Invoice < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :invoice_items, dependent: :destroy
  has_many :reconciliations, as: :matchable, dependent: :destroy

  accepts_nested_attributes_for :invoice_items, allow_destroy: true
  enum :status, { draft: 'draft', issued: 'issued', paid: 'paid', canceled: 'canceled' }, default: 'draft'

  validates :currency, :issued_on, presence: true
  validates :number, presence: true, uniqueness: { scope: [:user_id, :series] }

  before_save :compute_totals

  private
  # totals are computed via Billing::InvoiceCalculator before save
  def compute_totals
    out = Billing::InvoiceCalculator.call(self)

    self.subtotal_cents       = out.subtotal_cents
    self.iva_amount_cents     = out.iva_amount_cents
    self.irpf_withheld_cents  = out.irpf_withheld_cents
    self.total_cents          = out.total_cents
  end
end
