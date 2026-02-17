import { Navigate, Route, Routes } from "react-router-dom"
import { HomePage } from "./pages/HomePage"
import { Layout } from "./components/layout/Layout"
import { DashboardPage } from "./pages/Dashboard"

function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<Navigate to="/dashboard" replace />} />
        <Route path="/home" element={<HomePage />} />
        <Route path="/dashboard" element={<DashboardPage />} />
      </Routes>
    </Layout>
  )
}

export default App
