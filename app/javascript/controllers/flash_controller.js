import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    setTimeout(() => {
      this.dismiss()
    }, 5000)
  }

  dismiss() {
    this.element.style.transition = "opacity 0.3s, transform 0.3s"
    this.element.style.opacity = "0"
    this.element.style.transform = "translateY(-10px)"
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}
