import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import rangePlugin from "flatpickrRangePlugin"

// Connects to data-controller="flatpickr"
export default class extends Controller {

  static targets = [ 'startInput', 'endInput' ]

  connect() {
    flatpickr(this.startInputTarget, {
      // mode: 'range',
      inline: true,
      enableTime: true,
      minDate: new Date(),
      "plugins": [new rangePlugin({ input: this.endInputTarget})]
    })
  }
}
