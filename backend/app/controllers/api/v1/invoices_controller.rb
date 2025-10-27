class Api::V1::InvoicesController < ApplicationController
  before_action :authenticate!
  before_action :set_invoice, only: %i[show update issue mark_paid cancel]

  def index
    invoices = current_user.invoices.includes(:client, :invoice_items).order(issued_on: :desc, id: :desc)
    render json: invoices.map { |i| serialize(i) }
  end

  def show
    render json: serialize(@invoice)
  end

  def create
    inv = current_user.invoices.new(invoice_params)
    
    if inv.save
      render json: serialize(inv), status: :created
    else
      render json: { errors: inv.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @invoice.update(invoice_params)
      render json: serialize(@invoice)
    else
      render json: { errors: @invoice.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # stubs for later:
  def issue; head :not_implemented; end
  def mark_paid; head :not_implemented; end
  def cancel; head :not_implemented; end

  private

  def set_invoice
    @invoice = current_user.invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(
      :client_id, :number, :series, :issued_on, :due_on, :currency, :notes, :status,
      invoice_items_attributes: %i[id description quantity unit_price_cents discount_cents iva_rate irpf_rate _destroy]
    )
  end

  def serialize(inv)
    {
      id: inv.id,
      number: inv.number,
      series: inv.series,
      issued_on: inv.issued_on,
      due_on: inv.due_on,
      status: inv.status,
      currency: inv.currency,
      client: {
        id: inv.client_id,
        name: inv.client.name,
        tax_id: inv.client.tax_id
      },
      items: inv.invoice_items.map do |it|
        {
          id: it.id,
          description: it.description,
          quantity: it.quantity,
          unit_price_cents: it.unit_price_cents,
          discount_cents: it.discount_cents,
          iva_rate: it.iva_rate,
          irpf_rate: it.irpf_rate,
          line_base_cents: it.base_cents
        }
      end,
      totals: {
        subtotal_cents: inv.subtotal_cents,
        iva_amount_cents: inv.iva_amount_cents,
        irpf_withheld_cents: inv.irpf_withheld_cents,
        total_cents: inv.total_cents
      },
      notes: inv.notes
    }
  end
end
