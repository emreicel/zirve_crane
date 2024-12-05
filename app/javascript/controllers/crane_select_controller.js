import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "crane_fixing",
    "crane_chassis_size",
    "crane_mast_size",
    "height",
    "boomLength",
    "tonnage",
    "boomTonnage"
  ]

  connect() {
    console.log("Crane select controller connected")
  }

  updateCraneInfo(event) {
    const craneId = event.target.value
    if (!craneId) {
      this.clearInfo()
      return
    }

    fetch(`/cranes/${craneId}.json`)
      .then(response => response.json())
      .then(data => {
        this.crane_fixingTarget.textContent = data.crane_fixing || '-'
        this.crane_chassis_sizeTarget.textContent = data.crane_chassis_size || '-'
        this.crane_mast_sizeTarget.textContent = data.crane_mast_size || '-'
        this.heightTarget.textContent = data.crane_height ? `${data.crane_height} m` : '-'
        this.boomLengthTarget.textContent = data.crane_boom_length ? `${data.crane_boom_length} m` : '-'
        this.tonnageTarget.textContent = data.crane_tonnage ? `${data.crane_tonnage} kg` : '-'
        this.boomTonnageTarget.textContent = data.crane_boom_tonnage ? `${data.crane_boom_tonnage} kg` : '-'
      })
      .catch(error => {
        console.error('Error:', error)
        this.clearInfo()
      })
  }

  clearInfo() {
    this.crane_fixingTarget.textContent = '-'
    this.crane_chassis_sizeTarget.textContent = '-'
    this.crane_mast_sizeTarget.textContent = '-'
    this.heightTarget.textContent = '-'
    this.boomLengthTarget.textContent = '-'
    this.tonnageTarget.textContent = '-'
    this.boomTonnageTarget.textContent = '-'
  }
}