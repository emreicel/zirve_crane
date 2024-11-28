import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["height", "boomLength", "tonnage"]

  connect() {
    console.log("Crane select controller connected") // Debug için
  }

  updateCraneInfo(event) {
    console.log("Updating crane info...") // Debug için
    const craneId = event.target.value
    
    if (!craneId) {
      this.clearCraneInfo()
      return
    }

    fetch(`/cranes/${craneId}/info`, {
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
      .then(response => {
        console.log("Response received") // Debug için
        return response.json()
      })
      .then(data => {
        console.log("Data received:", data) // Debug için
        document.getElementById('crane-height').textContent = `${data.height} m`
        document.getElementById('crane-boom-length').textContent = `${data.boom_length} m`
        document.getElementById('crane-tonnage').textContent = `${data.tonnage} ton`
      })
      .catch(error => {
        console.error("Error fetching crane info:", error)
      })
  }

  clearCraneInfo() {
    document.getElementById('crane-height').textContent = ''
    document.getElementById('crane-boom-length').textContent = ''
    document.getElementById('crane-tonnage').textContent = ''
  }
}