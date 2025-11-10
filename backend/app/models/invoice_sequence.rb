class InvoiceSequence < ApplicationRecord
  belongs_to :user
  
  validates :series, :year, presence: true, uniqueness: { scope: [:user_id] }
end
