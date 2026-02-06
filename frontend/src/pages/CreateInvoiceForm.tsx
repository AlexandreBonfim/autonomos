import { useState } from "react";
import { createInvoice } from "../api/invoices";

export default function CreateInvoiceForm({
  onCreated,
}: {
  onCreated: (invoice: any) => void;
}) {
  const [clientId, setClientId] = useState("");
  const [issuedOn, setIssuedOn] = useState("");
  const [description, setDescription] = useState("");
  const [amount, setAmount] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();

    const payload = {
      client_id: Number(clientId),
      issued_on: issuedOn,
      currency: "EUR",
      invoice_items_attributes: [
        {
          description,
          quantity: 1,
          unit_price_cents: Math.round(Number(amount) * 100),
          discount_cents: 0,
          iva_rate: 21,
          irpf_rate: 0,
        },
      ],
    };

    const invoice = await createInvoice(payload);
    onCreated(invoice);
  }

  return (
    <form onSubmit={handleSubmit}>
      <h2>New Invoice</h2>

      <input
        placeholder="Client ID"
        value={clientId}
        onChange={e => setClientId(e.target.value)}
      />

      <input
        type="date"
        value={issuedOn}
        onChange={e => setIssuedOn(e.target.value)}
      />

      <input
        placeholder="Description"
        value={description}
        onChange={e => setDescription(e.target.value)}
      />

      <input
        placeholder="Amount (€)"
        value={amount}
        onChange={e => setAmount(e.target.value)}
      />

      <button>Create</button>
    </form>
  );
}
