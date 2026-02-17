import { render, screen, within } from "@testing-library/react"
import { describe, expect, it } from "vitest"
import { DashboardPage } from "./Dashboard"

describe("DashboardPage", () => {
  it("renders the KPI row", () => {
    render(<DashboardPage />)

    expect(screen.getByText("Total facturado")).toBeInTheDocument()
    expect(screen.getByText("Gastos")).toBeInTheDocument()
    expect(screen.getByText("Reservado para Hacienda")).toBeInTheDocument()

    expect(
      within(screen.getByRole("group", { name: "Total facturado" })).getByText(
        "€12.430",
      ),
    ).toBeInTheDocument()
    expect(
      within(screen.getByRole("group", { name: "Gastos" })).getByText("€3.200"),
    ).toBeInTheDocument()
    expect(
      within(
        screen.getByRole("group", { name: "Reservado para Hacienda" }),
      ).getByText("€2.100"),
    ).toBeInTheDocument()
  })

  it("renders the safe-to-spend card", () => {
    render(<DashboardPage />)

    const safeToSpendCard = screen.getByRole("group", {
      name: "Seguro para gastar",
    })
    expect(within(safeToSpendCard).getByText("€7.130")).toBeInTheDocument()
    expect(within(safeToSpendCard).getByText("IVA:")).toBeInTheDocument()
    expect(within(safeToSpendCard).getByText("€1.540")).toBeInTheDocument()
    expect(within(safeToSpendCard).getByText("IRPF:")).toBeInTheDocument()
    expect(within(safeToSpendCard).getByText("€560")).toBeInTheDocument()
    expect(within(safeToSpendCard).getByText("Cierre del trimestre")).toBeInTheDocument()
    expect(within(safeToSpendCard).getByText("18 días")).toBeInTheDocument()
    expect(within(safeToSpendCard).getByText("Pago estimado")).toBeInTheDocument()
  })

  it("renders the quarter limit slider", () => {
    render(<DashboardPage />)

    expect(
      screen.getByRole("heading", { name: "Límite del trimestre" }),
    ).toBeInTheDocument()
    expect(
      screen.getByRole("slider", { name: "Límite del trimestre" }),
    ).toBeInTheDocument()
  })
})

