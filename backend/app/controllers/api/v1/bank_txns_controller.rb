class Api::V1::BankTxnsController < ApplicationController
  before_action :authenticate!
  before_action :set_txn, only: %i[show candidates]

  def index
    txns = current_user.bank_txns.order(occurred_on: :desc, id: :desc)
    render json: txns.map { |t| serialize(t) }
  end

  def show
    render json: serialize(@txn)
  end

  def create
    t = current_user.bank_txns.new(bank_txn_params)
    if t.save
      render json: serialize(t), status: :created
    else
      render json: { errors: t.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def import_csv
    csv_text = params[:csv].to_s
    count = Banking::CsvImporter.call(user: current_user, io: StringIO.new(csv_text), source: 'api_csv')
    render json: { imported: count }, status: :created
  end

  def candidates
    render json: Banking::Matcher.call(current_user, @txn)
  end

  private

  def set_txn
    @txn = current_user.bank_txns.find(params[:id])
  end

  def bank_txn_params
    params.require(:bank_txn).permit(:occurred_on, :amount_cents, :currency, :description, :external_id, :source)
          .merge(status: 'unreconciled')
  end

  def serialize(t)
    {
      id: t.id,
      occurred_on: t.occurred_on,
      amount_cents: t.amount_cents,
      currency: t.currency,
      description: t.description,
      status: t.status,
      external_id: t.external_id
    }
  end
end