import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ["sidebar"]
  connect() {
  }
	toggleSidebar() {
		this.sidebarTarget.classList.toggle("-translate-x-full")
	}
}
