// app/javascript/controllers/contracts_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["startDate", "rentTerm", "finishDate"];

  connect() {
    this.calculateFinishDate();
  }

  calculateFinishDate() {
    const startDateValue = this.startDateTarget.value;
    const rentTermValue = parseInt(this.rentTermTarget.value, 10);

    if (startDateValue && rentTermValue) {
      const startDate = new Date(startDateValue);
      startDate.setMonth(startDate.getMonth() + rentTermValue);
      
      // Format the finish date to YYYY-MM-DD
      const finishDate = startDate.toISOString().split("T")[0];
      this.finishDateTarget.value = finishDate;
    }
  }
}
