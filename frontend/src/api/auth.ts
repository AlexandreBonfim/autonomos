import api from "./client";

export async function login(email: string, password: string) {
  const res = await api.post("/auth/login", { email, password });
  return res.data.token;
}

export async function signup(email: string, password: string, name: string) {
  const res = await api.post("/auth/signup", { email, password, name });
  return res.data.token;
}
