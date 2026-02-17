import { SlidersHorizontal } from "lucide-react"
import { useId, useState } from "react"

export function QuarterLimitCard() {
  const sliderId = useId()
  const [value, setValue] = useState(35)

  return (
    <div className="bg-white border border-zinc-200 rounded-2xl px-5 py-4 shadow-sm">
      <div className="flex items-center justify-between gap-4">
        <div className="flex items-center gap-3 text-zinc-700">
          <div className="h-9 w-9 rounded-xl bg-zinc-100 flex items-center justify-center">
            <SlidersHorizontal size={18} className="text-zinc-500" />
          </div>
          <div className="leading-tight">
            <h3 className="text-sm font-medium text-zinc-800">
              Límite del trimestre
            </h3>
            <p className="text-xs text-zinc-500">
              Ajusta cuánto quieres reservar automáticamente
            </p>
          </div>
        </div>

        <div className="text-sm font-medium text-zinc-700 tabular-nums">
          {value}%
        </div>
      </div>

      <div className="mt-4">
        <label htmlFor={sliderId} className="sr-only">
          Límite del trimestre
        </label>
        <input
          id={sliderId}
          aria-label="Límite del trimestre"
          type="range"
          min={0}
          max={100}
          value={value}
          onChange={(e) => setValue(Number(e.target.value))}
          className="w-full accent-emerald-600"
        />
      </div>
    </div>
  )
}

