import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.debounceTimer = null
    document.addEventListener("click", this.handleOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
    clearTimeout(this.debounceTimer)
  }

  search() {
    clearTimeout(this.debounceTimer)
    const query = this.inputTarget.value.trim()

    if (query.length < 2) {
      this.hideResults()
      return
    }

    this.debounceTimer = setTimeout(() => {
      fetch(`/search?q=${encodeURIComponent(query)}`, {
        headers: { "Accept": "text/vnd.turbo-stream.html" }
      })
        .then(r => r.text())
        .then(html => {
          this.resultsTarget.innerHTML = html
          this.showResults()
        })
    }, 300)
  }

  showResults() {
    this.resultsTarget.classList.add("active")
  }

  hideResults() {
    this.resultsTarget.classList.remove("active")
  }

  handleOutsideClick = (event) => {
    if (!this.element.contains(event.target)) {
      this.hideResults()
    }
  }
}
