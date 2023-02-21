import { Controller } from "stimulus"
import flatpickr from 'flatpickr';

export default class extends Controller {
  static targets = [ "start", "end" ]

  connect() {    
    flatpickr(this.element);    
  }
}
