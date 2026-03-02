import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { target: Number, duration: { type: Number, default: 1000 }, suffix: { type: String, default: "" } }

  connect() {
    this.animate()
  }

  animate() {
    const target = this.targetValue
    const duration = this.durationValue
    const suffix = this.suffixValue
    const start = performance.now()
    const el = this.element

    const step = (now) => {
      const progress = Math.min((now - start) / duration, 1)
      const eased = 1 - Math.pow(1 - progress, 3)
      const current = Math.round(eased * target)
      el.textContent = current.toLocaleString("id-ID") + suffix
      if (progress < 1) requestAnimationFrame(step)
    }

    requestAnimationFrame(step)
  }
}
