import {
  FileText,
  LayoutDashboard,
  LineChart,
  Receipt,
  Settings,
  Sprout,
} from 'lucide-react'
import { NavLink } from 'react-router-dom'

const navItems = [
  { label: 'Dashboard', icon: LayoutDashboard, to: '/dashboard' },
  { label: 'Facturas', icon: FileText, to: '/facturas' },
  { label: 'Gastos', icon: Receipt, to: '/gastos' },
  { label: 'Proyecciones', icon: LineChart, to: '/proyecciones' },
  { label: 'Ajustes', icon: Settings, to: '/ajustes' },
]

export function Sidebar() {
  return (
    <aside className="hidden md:flex w-64 bg-white border-r border-zinc-200 flex-col p-6">
      <div className="mb-10 flex items-center gap-2">
        <div className="h-9 w-9 rounded-xl bg-emerald-50 flex items-center justify-center border border-emerald-100">
          <Sprout size={18} className="text-emerald-700" />
        </div>
        <h1 className="text-lg font-semibold tracking-tight">AutonomOS</h1>
      </div>

      <nav className="space-y-2">
        {navItems.map(({ label, icon: Icon, to }) => (
          <NavLink
            key={label}
            to={to}
            className={({ isActive }) =>
              `flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition ${
                isActive
                  ? 'bg-emerald-50 text-emerald-800 border border-emerald-100'
                  : 'text-zinc-600 hover:bg-zinc-100 hover:text-zinc-900 border border-transparent'
              }`
            }
          >
            <Icon size={18} />
            {label}
          </NavLink>
        ))}
      </nav>
    </aside>
  )
}
