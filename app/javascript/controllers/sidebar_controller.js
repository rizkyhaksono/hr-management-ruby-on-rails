import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "overlay"]

  connect() {
    const saved = localStorage.getItem("sidebar-open")
    if (window.innerWidth <= 768) {
      this.close()
    } else if (saved === "false") {
      this.sidebarTarget.classList.remove("open")
    }
  }

  toggle() {
    if (this.sidebarTarget.classList.contains("open")) {
      this.close()
    } else {
      this.open()
    }
  }

  open() {
    this.sidebarTarget.classList.add("open")
    this.overlayTarget.classList.add("active")
    localStorage.setItem("sidebar-open", "true")
  }

  close() {
    this.sidebarTarget.classList.remove("open")
    this.overlayTarget.classList.remove("active")
    localStorage.setItem("sidebar-open", "false")
  }
}
