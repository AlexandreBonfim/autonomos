module Taxation
  class Ledger
    Result = Struct.new(
      :period, 
      :currency,
      :invoices_count,
      :expenses_count,
      :base_invoices_cents,
      :iva_repercutido_cents,
      :irpf_retenido_cents,
      :base_expenses_cents,
      :iva_soportado_cents,
      :iva_net_to_pay_cents,
      :irpf_to_declare_cents,
      keyword_init: true
    )

    # Computes ledgers for a user in a period (Date range).
    # Assumes:
    #  - Invoices: subtotal_cents, iva_amount_cents, irpf_withheld_cents
    #  - Expenses: iva_amount_cents, total_cents and net base = total - iva + irpf
    def self.call(user:, period:)
      from, to = period.from, period.to

      invs = user.invoices.in_period(from, to)
      exps = user.expenses.in_period(from, to)

      base_invoices  = invs.sum(:subtotal_cents)
      iva_repercut   = invs.sum(:iva_amount_cents)
      irpf_retenido  = invs.sum(:irpf_withheld_cents)

      # expense base = total - iva + irpf_withheld_on_expense (usually 0)
      expense_rows = exps.pluck(:total_cents, :iva_amount_cents, :irpf_withheld_cents)
      base_expenses = 0
      iva_soportado = 0
      expense_rows.each do |total, iva, irpf|
        base_expenses += (total - iva + irpf.to_i)
        iva_soportado += iva.to_i
      end

      iva_net = iva_repercut - iva_soportado
      # IRPF “to declare” depends on model (130/131); here we report retentions to be summarized.
      irpf_to_declare = irpf_retenido

      Result.new(
        period: period.to_h,
        currency: 'EUR',
        invoices_count: invs.count,
        expenses_count: exps.count,
        base_invoices_cents: base_invoices,
        iva_repercutido_cents: iva_repercut,
        irpf_retenido_cents: irpf_retenido,
        base_expenses_cents: base_expenses,
        iva_soportado_cents: iva_soportado,
        iva_net_to_pay_cents: iva_net,
        irpf_to_declare_cents: irpf_to_declare
      )
    end
  end
end
