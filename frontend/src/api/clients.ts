import api from "./client";

export type Client = {
  id: number;
  name: string;
  tax_id?: string;
};

export async function fetchClients(): Promise<Client[]> {
  const res = await api.get("/clients");
  return res.data;
}
