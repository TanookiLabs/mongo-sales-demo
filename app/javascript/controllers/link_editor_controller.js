import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'placeholder', 'modal', 'screenSelect', 'submitButton', 'externalUrl' ]

  initialize() {
    this.$el = $(this.element);

    this.constructor.targets.forEach(target => {
      this[`$${target}`] = $(this[`${target}Target`]);
    });

    this.$form = this.$modal.find('form');

    this.$modal.on('hide.bs.modal', () => {
      this.$placeholder.hide();
    });

    this.startPos = [];
    this.linkBox = [];
    this.dragTarget = null;

    this.$el.on('dragstart', (e) => {
      e.preventDefault();
    });

    this.$el.on('mousedown', (e) => {
      this.startPos = [e.pageX, e.pageY];
    });

    this.$el.on('mousemove', (e) => {
      if (this.dragTarget) {
        const x = e.pageX - this.dragPos[0];
        const y = e.pageY - this.dragPos[1];

        if (x !== 0 || y !== 0) {
          this.dragTargetMoved = true;
        }

        const ePercChangeX = x / this.$el.width() * 100;
        const ePercChangeY = y / this.$el.height() * 100;

        this.dragTarget.style.left = `${parseFloat(this.dragTarget.style.left.slice(0, -1)) + ePercChangeX}%`;
        this.dragTarget.style.right = `${parseFloat(this.dragTarget.style.right.slice(0, -1)) - ePercChangeX}%`;
        this.dragTarget.style.top = `${parseFloat(this.dragTarget.style.top.slice(0, -1)) + ePercChangeY}%`;
        this.dragTarget.style.bottom = `${parseFloat(this.dragTarget.style.bottom.slice(0, -1)) - ePercChangeY}%`;
        this.dragPos = [e.pageX, e.pageY];
      } else if (this.startPos.length) {
        this.calculateLinkBox(e.pageX, e.pageY);

        if (this.hasLinkBoxArea) {
          this.$placeholder.css(this.linkBoxPercentages).show();
        } else {
          this.$placeholder.hide();
        }
      }
    });

    this.$el.on('mouseup', (e) => {
      if (this.dragTarget) {
        if (this.dragTargetMoved) {
          $.ajax({
            method: 'PATCH',
            url: $(this.dragTarget).data('url'),
            data: {
              left: this.dragTarget.style.left,
              right: this.dragTarget.style.right,
              top: this.dragTarget.style.top,
              bottom: this.dragTarget.style.bottom
            }
          });
        } else {
          if (confirm('Remove this hotlink?')) {
            $.ajax({
              method: 'DELETE',
              url: $(this.dragTarget).data('url')
            });
            this.dragTarget.remove();
          }
        }

        this.dragTarget = null;
      } else {
        if (this.hasLinkBoxArea && !this.$modal.is(':visible')) {
          this.$form.find('input[name=left]').val(this.linkBoxPercentages.left);
          this.$form.find('input[name=top]').val(this.linkBoxPercentages.top);
          this.$form.find('input[name=right]').val(this.linkBoxPercentages.right);
          this.$form.find('input[name=bottom]').val(this.linkBoxPercentages.bottom);

          // reset the form
          this.$screenSelect.val('');
          this.$externalUrl.val('');
          this.updateControlState();

          this.$modal.modal('show');
        } else {
          this.$placeholder.hide();
        }
        this.startPos = [];
      }
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

  updateControlState() {
    this.$submitButton.prop('disabled', this.$screenSelect.val() == '' && this.$externalUrl.val() == '')
    this.$externalUrl.toggle(this.$screenSelect.val() == '');
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
    this.dragTarget = e.currentTarget;
    this.dragTargetMoved = false;
    this.dragPos = [e.pageX, e.pageY];
    e.stopPropagation();
  }
}
