import { useEffect, useState } from "react";
import { createInvoice } from "../api/invoices";
import { fetchClients, type Client } from "../api/clients";

export default function CreateInvoiceForm({
  onCreated,
}: {
  onCreated: (invoice: any) => void;
}) {
  const [clients, setClients] = useState<Client[]>([]);
  const [clientId, setClientId] = useState<number | "">("");
  const [issuedOn, setIssuedOn] = useState("");
  const [description, setDescription] = useState("");
  const [amount, setAmount] = useState("");

  useEffect(() => {
    fetchClients().then(setClients);
  }, []);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!clientId) return;

    const payload = {
      client_id: clientId,
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

      <select
        value={clientId}
        onChange={(e) => setClientId(Number(e.target.value))}
      >
        <option value="">Select client</option>
        {clients.map(c => (
          <option key={c.id} value={c.id}>
            {c.name} {c.tax_id ? `(${c.tax_id})` : ""}
          </option>
        ))}
      </select>

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

      <button disabled={!clientId}>Create</button>
    </form>
  );
}
