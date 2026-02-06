import { useState } from "react";
import { login } from "../api/auth";
import { useAuth } from "../auth/useAuth";

export default function LoginPage() {
  const { login: setToken } = useAuth();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    const token = await login(email, password);
    setToken(token);
  }

  return (
    <form onSubmit={handleSubmit}>
      <h1>Login</h1>
      <input value={email} onChange={e => setEmail(e.target.value)} />
      <input type="password" value={password} onChange={e => setPassword(e.target.value)} />
      <button>Login</button>
    </form>
  );
}
