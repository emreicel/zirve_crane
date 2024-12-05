import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["table"]

  connect() {
    console.log("PriceOfferDetails controller connected")
  }

  addRow(event) {
    event.preventDefault()
    const tbody = this.tableTarget.querySelector('tbody')
    const newRow = this.createRow()
    tbody.appendChild(newRow)
  }

  removeRow(event) {
    event.preventDefault()
    const row = event.target.closest('tr')
    row.remove()
  }

  calculateTotal(event) {
    const row = event.target.closest('tr')
    const quantity = parseFloat(row.querySelector('.quantity-input').value) || 0
    const price = parseFloat(row.querySelector('.price-input').value) || 0
    const total = quantity * price
    row.querySelector('.total-amount').textContent = total.toFixed(2)
  }

  createRow() {
    const rows = this.tableTarget.querySelectorAll('.detail-row')
    const index = rows.length
    const template = `
      <tr class="detail-row">
        <td>
          <input type="text" name="price_offer[price_offer_details_attributes][${index}][price_offer_list_description]" class="form-control">
        </td>
        <td>
          <input type="number" name="price_offer[price_offer_details_attributes][${index}][price_offer_list_quantity]" 
                 class="form-control quantity-input" 
                 data-action="input->price-offer-details#calculateTotal"
                 min="1">
        </td>
        <td>
          <input type="text" name="price_offer[price_offer_details_attributes][${index}][price_offer_list_unit]" class="form-control">
        </td>
        <td>
          <input type="number" name="price_offer[price_offer_details_attributes][${index}][price_offer_detail_unit_price]" 
                 class="form-control price-input" 
                 data-action="input->price-offer-details#calculateTotal"
                 step="0.01" 
                 min="0">
        </td>
        <td>
          <span class="total-amount">0.00</span>
        </td>
        <td>
          <button type="button" class="btn btn-sm btn-outline-danger" data-action="price-offer-details#removeRow">
            <i class="fas fa-trash"></i>
          </button>
        </td>
      </tr>
    `
    const tr = document.createElement('tr')
    tr.innerHTML = template
    return tr.firstElementChild
  }
}