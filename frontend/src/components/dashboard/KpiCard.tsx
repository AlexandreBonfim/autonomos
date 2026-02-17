import { motion } from 'framer-motion'

interface Props {
  title: string
  value: string
}

export function KpiCard({ title, value }: Props) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 15 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.3 }}
      className="bg-white border border-zinc-200 rounded-2xl p-5 shadow-sm"
      role="group"
      aria-label={title}
    >
      <p className="text-sm text-zinc-500">{title}</p>
      <p className="mt-2 text-2xl font-semibold tracking-tight">
        {value}
      </p>
    </motion.div>
  )
}
