import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { timeout: Number }

  connect() {
    let time = this.timeoutValue || 2000

    setTimeout(() => {
      this.element.classList.remove("show")
      setTimeout(() => this.element.remove(), 150)
    }, time)
  }
}
