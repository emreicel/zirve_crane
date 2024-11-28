import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  updateCustomerInfo(event) {
    const customerId = event.target.value
    if (!customerId) return

    fetch(`/customers/${customerId}/info`)
      .then(response => response.json())
      .then(data => {
        document.getElementById('customer-phone').value = data.phone_number
        document.getElementById('customer-email').value = data.email
      })
  }
}