import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]
  static values = {
    messageCount: Number
  }
  connect() {
    console.log("Hello chat!");
    console.log(this.buttonTarget)
    if(this.messageCountValue>=3) {
      this.buttonTarget.classList.add("d-none")
  }
  }
}
