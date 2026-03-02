import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { duration: { type: Number, default: 5000 } }

  connect() {
    this.timeout = setTimeout(() => this.dismiss(), this.durationValue)
  }

  dismiss() {
    clearTimeout(this.timeout)
    this.element.classList.add("removing")
    setTimeout(() => this.element.remove(), 300)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
