import { motion } from 'framer-motion'

export function SafeToSpendCard() {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.4 }}
      className="bg-white border border-zinc-200 rounded-2xl p-6 md:p-8 shadow-sm"
      role="group"
      aria-label="Seguro para gastar"
    >
      <div className="grid md:grid-cols-3 gap-8">
        {/* Left Main Section */}
        <div className="md:col-span-2">
          <p className="text-sm text-zinc-500 font-medium">Seguro para gastar</p>

          <h3 className="text-5xl md:text-6xl font-semibold text-emerald-700 mt-2 tracking-tight tabular-nums">
            €7.130
          </h3>

          <div className="mt-6 text-sm text-zinc-600">
            <p className="text-zinc-500">Estás proyectado a pagar:</p>
            <div className="mt-3 space-y-2">
              <p>
                <span className="font-semibold text-zinc-700">IVA:</span> €1.540
              </p>
              <p>
                <span className="font-semibold text-zinc-700">IRPF:</span> €560
              </p>
            </div>
          </div>
        </div>

        {/* Right Side Info */}
        <div className="border-t md:border-t-0 md:border-l border-zinc-200 pt-6 md:pt-0 md:pl-8 space-y-6">
          <div>
            <p className="text-sm text-zinc-600 font-medium">
              Cierre del trimestre
            </p>
            <p className="text-xs text-zinc-500 mt-2">El trimestre cierra en:</p>
            <p className="text-3xl font-semibold mt-2 tracking-tight tabular-nums">
              18 días
            </p>
          </div>

          <div className="h-px bg-zinc-200" />

          <div>
            <p className="text-sm text-zinc-600 font-medium">Pago estimado</p>
            <p className="text-3xl font-semibold mt-2 tracking-tight tabular-nums">
              €2.100
            </p>
            <div className="mt-5 h-2 w-40 rounded-full bg-zinc-100" />
          </div>
        </div>
      </div>
    </motion.div>
  )
}
