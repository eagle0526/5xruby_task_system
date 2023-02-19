import { Controller } from "stimulus"
import flatpickr from 'flatpickr';

export default class extends Controller {
  static targets = [  ]

  connect() {
    // console.log(123);
    flatpickr(this.element);
  }
}
