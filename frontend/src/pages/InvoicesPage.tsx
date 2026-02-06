import { useEffect, useState } from "react";
import { fetchInvoices } from "../api/invoices";
import CreateInvoiceForm from "./CreateInvoiceForm";

type Invoice = {
  id: number;
  number: string;
  issued_on: string;
  total_cents: number;
  status: string;
};

export default function InvoicesPage() {
  const [invoices, setInvoices] = useState<Invoice[]>([]);
  const [showForm, setShowForm] = useState(false);

  useEffect(() => {
    fetchInvoices().then(setInvoices);
  }, []);

  return (
    <div>
      <h1>Invoices</h1>

      <button onClick={() => setShowForm(v => !v)}>
        {showForm ? "Close" : "New invoice"}
      </button>

      {showForm && (
        <CreateInvoiceForm
          onCreated={(inv) => {
            setInvoices([inv, ...invoices]);
            setShowForm(false);
          }}
        />
      )}

      <ul>
        {invoices.map(inv => (
          <li key={inv.id}>
            #{inv.number || "draft"} –{" "}
            {inv.total_cents / 100} € – {inv.status}
          </li>
        ))}
      </ul>
    </div>
  );
}
