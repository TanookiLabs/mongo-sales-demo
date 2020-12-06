import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [  ]

  onKeyDown(e) {
    if (e.shiftKey) {
      $(this.element).addClass('m-screen-shift');
    }
  }

  onKeyUp(e) {
    if (e.keyCode == 16) {
      $(this.element).removeClass('m-screen-shift');
    }
  }
}
