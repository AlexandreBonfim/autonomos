import { KpiCard } from "../components/dashboard/KpiCard";
import { QuarterLimitCard } from "../components/dashboard/QuarterLimitCard";
import { SafeToSpendCard } from "../components/dashboard/SafeToSpendCard";

export function DashboardPage() {
  return (
    <div className="space-y-8">
      {/* KPI Row */}
      <div className="grid gap-4 md:grid-cols-4">
        <div className="md:col-span-1">
          <KpiCard title="Total facturado" value="€12.430" />
        </div>
        <div className="md:col-span-1">
          <KpiCard title="Gastos" value="€3.200" />
        </div>
        <div className="md:col-span-2">
          <KpiCard title="Reservado para Hacienda" value="€2.100" />
        </div>
      </div>

      {/* Main Block */}
      <SafeToSpendCard />
      <QuarterLimitCard />
    </div>
  )
}
