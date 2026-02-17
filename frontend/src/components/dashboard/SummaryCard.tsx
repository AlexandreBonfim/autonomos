interface SummaryCardProps {
    title: string
    value: string
    highlight?: boolean
  }
  
  export function SummaryCard({
    title,
    value,
    highlight = false,
  }: SummaryCardProps) {
    return (
      <div className="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
        <p className="text-sm text-gray-500">{title}</p>
        <p
          className={`mt-2 text-2xl font-semibold ${
            highlight ? 'text-primary' : 'text-text'
          }`}
        >
          {value}
        </p>
      </div>
    )
  }
  