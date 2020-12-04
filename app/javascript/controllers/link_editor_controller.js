import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'placeholder', 'modal', 'screenSelect' ]

  initialize() {
    this.$el = $(this.element);
    this.$placeholder = $(this.placeholderTarget);
    this.$modal = $(this.modalTarget);
    this.$screenSelect = $(this.screenSelectTarget);
    this.$form = this.$modal.find('form');

    this.$modal.on('hide.bs.modal', () => {
      this.$placeholder.hide();
    });

    this.startPos = []
    this.linkBox = []

    this.$el.on('dragstart', (e) => {
      e.preventDefault();
    });

    this.$el.on('mousedown', (e) => {
      this.startPos = [e.pageX, e.pageY];
    });

    this.$el.on('mousemove', (e) => {
      if (this.startPos.length) {
        this.calculateLinkBox(e.pageX, e.pageY);

        if (this.hasLinkBoxArea) {
          this.$placeholder.css(this.linkBoxPercentages).show();
        } else {
          this.$placeholder.hide();
        }
      }
    });
    this.$el.on('mouseup', (e) => {
      if (this.hasLinkBoxArea) {
        this.$form.find('input[name=left]').val(this.linkBoxPercentages.left);
        this.$form.find('input[name=top]').val(this.linkBoxPercentages.top);
        this.$form.find('input[name=right]').val(this.linkBoxPercentages.right);
        this.$form.find('input[name=bottom]').val(this.linkBoxPercentages.bottom);
        this.$modal.modal('show');
      } else {
        this.$placeholder.hide();
      }
      this.startPos = [];
    });
  }

  calculateLinkBox(curX, curY) {
    this.linkBox = [
      Math.min(this.startPos[0], curX),
      Math.min(this.startPos[1], curY),
      Math.max(this.startPos[0], curX),
      Math.max(this.startPos[1], curY)
    ];

    this.linkBoxPercentages = {
      left: `${this.linkBox[0] / this.$el.width() * 100}%`,
      top: `${this.linkBox[1] / this.$el.height() * 100}%`,
      right: `${100 - (this.linkBox[2] / this.$el.width() * 100)}%`,
      bottom: `${100 - (this.linkBox[3] / this.$el.height() * 100)}%`
    }
  }

  get hasLinkBoxArea() {
    return this.startPos.length && this.linkBox.length && (this.linkBox[0] !== this.linkBox[2] && this.linkBox[1] !== this.linkBox[3]);
  }

  onSubmit() {
    this.$form.ajaxSubmit({
      success: (response) => {
        this.$el.append(response);
        this.$modal.modal('hide');
      }
    });
  }

  onDelete(e) {
    e.stopPropagation();

    $.ajax({
      method: 'DELETE',
      url: $(e.target).data('url')
    });
    $(e.target).remove();
  }
}