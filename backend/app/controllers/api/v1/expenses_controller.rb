class Api::V1::ExpensesController < ApplicationController
  before_action :authenticate!
  before_action :set_expense, only: %i[show update]

  def index
    expenses = current_user.expenses.order(issued_on: :desc)
    render json: expenses.map { |e| serialize(e) }
  end

  def show
    render json: serialize(@expense)
  end

  def create
    e = current_user.expenses.new(expense_params)
    if e.save
      render json: serialize(e), status: :created
    else
      render json: { errors: e.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
      render json: serialize(@expense)
    else
      render json: { errors: @expense.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(
      :description, :total_cents, :currency, :iva_rate, :iva_amount_cents,
      :irpf_rate, :irpf_withheld_cents, :deductible_percent, :issued_on,
      :supplier_name, :supplier_tax_id, :document_id, :category, :status
    )
  end

  def serialize(e)
    {
      id: e.id,
      description: e.description,
      issued_on: e.issued_on,
      totals: {
        total_cents: e.total_cents,
        iva_amount_cents: e.iva_amount_cents,
        irpf_withheld_cents: e.irpf_withheld_cents,
        net_base_cents: e.net_base_cents,
        deductible_cents: e.deductible_cents,
        currency: e.currency
      },
      supplier: {
        name: e.supplier_name,
        tax_id: e.supplier_tax_id
      },
      category: e.category,
      status: e.status
    }
  end
end
