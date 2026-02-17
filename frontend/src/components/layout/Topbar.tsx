import { ChevronDown, Search } from 'lucide-react'

export function Topbar() {
  return (
    <header className="h-16 bg-white border-b border-zinc-200 flex items-center justify-between px-4 md:px-8">
      <h2 className="text-lg md:text-xl font-semibold tracking-tight">
        Dashboard
      </h2>

      <div className="flex items-center gap-3">
        <button
          type="button"
          className="p-2 rounded-lg hover:bg-zinc-100 transition"
          aria-label="Buscar"
        >
          <Search size={18} />
        </button>

        <button
          type="button"
          className="bg-emerald-600 text-white px-4 py-2 rounded-xl text-sm font-medium hover:bg-emerald-700 transition inline-flex items-center gap-2"
          aria-label="Menú de usuario"
        >
          Pregader
          <ChevronDown size={16} className="opacity-90" />
        </button>
      </div>
    </header>
  )
}
