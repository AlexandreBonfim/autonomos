class Api::V1::ReconciliationsController < ApplicationController
  before_action :authenticate!

  def create
    txn = current_user.bank_txns.find(params[:bank_txn_id])
    matchable = find_matchable!(params[:matchable_type], params[:matchable_id])

    rec = current_user.reconciliations.create!(
      bank_txn: txn,
      matchable: matchable,
      matched_amount: params[:matched_amount].presence || (txn.amount_cents.abs / 100.0)
    )

    txn.update!(status: 'reconciled')

    render json: serialize(rec), status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Not found' }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: rec.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def find_matchable!(type, id)
    case type
    when 'Expense' then current_user.expenses.find(id)
    when 'Invoice' then current_user.invoices.find(id)
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def serialize(rec)
    {
      id: rec.id,
      bank_txn_id: rec.bank_txn_id,
      matchable_type: rec.matchable_type,
      matchable_id: rec.matchable_id,
      matched_amount: rec.matched_amount.to_f
    }
  end
end
