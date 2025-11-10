class Api::V1::Tax::SummariesController < ApplicationController
  before_action :authenticate!

  def quarter
    period = Taxation::Period.quarter(year: params[:year], q: params[:q])
    render json: serialize(period)
  end

  def month
    period = Taxation::Period.month(year: params[:year], m: params[:m])
    render json: serialize(period)
  end

  private

  def serialize(period)
    r = Taxation::Ledger.call(user: current_user, period: period)
    {
      period: r.period,
      currency: r.currency,
      counts: {
        invoices: r.invoices_count,
        expenses: r.expenses_count
      },
      invoices: {
        base_cents: r.base_invoices_cents,
        iva_repercutido_cents: r.iva_repercutido_cents,
        irpf_retenido_cents: r.irpf_retenido_cents
      },
      expenses: {
        base_cents: r.base_expenses_cents,
        iva_soportado_cents: r.iva_soportado_cents
      },
      totals: {
        iva_net_to_pay_cents: r.iva_net_to_pay_cents,
        irpf_to_declare_cents: r.irpf_to_declare_cents
      }
    }
  end
end
