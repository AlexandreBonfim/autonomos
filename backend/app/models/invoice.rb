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
<<<<<<< HEAD
  has_many :reconciliations, as: :matchable, dependent: :destroy
=======
>>>>>>> 4d54d17 (feat(billing): add Invoice model with IVA/IRPF fields)
end
