import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    type: { type: String, default: "bar" },
    labels: Array,
    datasets: Array,
    options: { type: Object, default: {} }
  }

  async connect() {
    const { Chart, registerables } = await import("chart.js")
    Chart.register(...registerables)
    this.createChart(Chart)
  }

  createChart(Chart) {
    const isDark = document.documentElement.getAttribute("data-theme") === "dark"
    const textColor = isDark ? "#cbd5e1" : "#475569"
    const gridColor = isDark ? "rgba(255,255,255,0.06)" : "rgba(0,0,0,0.06)"

    const defaultOptions = {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: this.typeValue === "doughnut" || this.typeValue === "pie",
          position: "bottom",
          labels: { color: textColor, padding: 16, usePointStyle: true, pointStyleWidth: 8, font: { family: "Inter, sans-serif", size: 12 } }
        },
        tooltip: {
          backgroundColor: isDark ? "#1e293b" : "#ffffff",
          titleColor: isDark ? "#f1f5f9" : "#0f172a",
          bodyColor: isDark ? "#cbd5e1" : "#475569",
          borderColor: isDark ? "#334155" : "#e2e8f0",
          borderWidth: 1,
          cornerRadius: 8,
          padding: 10,
          titleFont: { family: "Inter, sans-serif", weight: "600" },
          bodyFont: { family: "Inter, sans-serif" },
          displayColors: true,
          boxPadding: 4
        }
      },
      scales: this.typeValue === "doughnut" || this.typeValue === "pie" ? {} : {
        x: {
          grid: { color: gridColor, drawBorder: false },
          ticks: { color: textColor, font: { family: "Inter, sans-serif", size: 11 } }
        },
        y: {
          grid: { color: gridColor, drawBorder: false },
          ticks: { color: textColor, font: { family: "Inter, sans-serif", size: 11 } },
          beginAtZero: true
        }
      }
    }

    const canvas = this.element.querySelector("canvas") || this.element
    if (canvas.tagName !== "CANVAS") return

    this.chart = new Chart(canvas, {
      type: this.typeValue,
      data: { labels: this.labelsValue, datasets: this.datasetsValue },
      options: { ...defaultOptions, ...this.optionsValue }
    })
  }

  disconnect() {
    if (this.chart) this.chart.destroy()
  }
}
