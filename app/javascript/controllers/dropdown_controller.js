import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    document.addEventListener("click", this.handleOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
  }

  toggle(event) {
    event.stopPropagation()
    document.querySelectorAll(".dropdown-menu.active").forEach(m => {
      if (m !== this.menuTarget) m.classList.remove("active")
    })
    this.menuTarget.classList.toggle("active")
  }

  close() {
    this.menuTarget.classList.remove("active")
  }

  handleOutsideClick = (event) => {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}
