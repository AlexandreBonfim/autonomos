import api from "./client";

export type InvoiceItemPayload = {
  description: string;
  quantity: number;
  unit_price_cents: number;
  discount_cents: number;
  iva_rate: number;
  irpf_rate: number;
};

export type InvoicePayload = {
  client_id: number;
  issued_on: string;
  currency: string;
  invoice_items_attributes: InvoiceItemPayload[];
};

export async function fetchInvoices() {
  const res = await api.get("/invoices");
  return res.data;
}

export async function createInvoice(payload: InvoicePayload) {
  const res = await api.post("/invoices", payload);
  return res.data;
}
