import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];
  static values = { start: Number, end: Number }; // end exclusivo

  validate() {
    const value = this.inputTarget.value;
    if (!value) return true;
    const dt = new Date(value);        // datetime-local -> hora local
    if (isNaN(dt)) return true;

    const hour = dt.getHours();
    const ok = hour >= this.startValue && hour < this.endValue;

    if (!ok) {
      alert("Solo se puede solicitar turnos de 7 AM a 17 PM");
      this.inputTarget.value = "";
      this.inputTarget.focus();
    }
    return ok;
  }

  submit(event) {
    if (!this.validate()) event.preventDefault();
  }
}
