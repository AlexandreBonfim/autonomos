module Banking
  class Matcher
    # Finds candidate Expenses/Invoices by amount equality (absolute) within date window
    # Outgoing (amount_cents < 0) → match Expenses by total_cents
    # Incoming (amount_cents > 0) → match Invoices by total_cents
    def self.call(user, bank_txn, date_window_days: 7, tolerance_cents: 0)
      date_from = bank_txn.occurred_on - date_window_days
      date_to   = bank_txn.occurred_on + date_window_days
      amount = bank_txn.amount_cents.abs

      if bank_txn.amount_cents.negative?
        exps = user.expenses.where(issued_on: date_from..date_to)
                             .where(total_cents: (amount - tolerance_cents)..(amount + tolerance_cents))
        {
          type: 'expense',
          candidates: exps.limit(10).map { |e| serialize_expense(e) }
        }
      else
        invs = user.invoices.where(issued_on: date_from..date_to)
                            .where(total_cents: (amount - tolerance_cents)..(amount + tolerance_cents))
        {
          type: 'invoice',
          candidates: invs.limit(10).map { |i| serialize_invoice(i) }
        }
      end
    end

    def self.serialize_expense(e)
      { kind: 'Expense', id: e.id, issued_on: e.issued_on, total_cents: e.total_cents,
        supplier_name: e.supplier_name, description: e.description }
    end

    def self.serialize_invoice(i)
      { kind: 'Invoice', id: i.id, issued_on: i.issued_on, total_cents: i.total_cents,
        number: i.number, client_name: i.client.name }
    end
  end
end
