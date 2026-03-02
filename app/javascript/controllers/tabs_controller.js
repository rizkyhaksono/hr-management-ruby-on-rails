import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "panel"]

  connect() {
    if (this.btnTargets.length > 0 && !this.btnTargets.some(b => b.classList.contains("active"))) {
      this.select({ currentTarget: this.btnTargets[0] })
    }
  }

  select(event) {
    const selectedTab = event.currentTarget.dataset.tab

    this.btnTargets.forEach(btn => {
      btn.classList.toggle("active", btn.dataset.tab === selectedTab)
    })

    this.panelTargets.forEach(panel => {
      panel.classList.toggle("active", panel.dataset.tab === selectedTab)
    })
  }
}
