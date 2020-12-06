import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [  ]

  onRemove(e) {
    e.preventDefault();
    const $el = $(this.element);
    $el.hide().append('<input type="hidden" value="1" name="screen[sales_items_attributes][][_destroy]">');
  }
}
