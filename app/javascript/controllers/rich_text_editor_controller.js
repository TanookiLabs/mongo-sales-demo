import { Controller } from "stimulus"
import Quill from "quill";

export default class extends Controller {
  static targets = [ "container" ]

  initialize() {
    // hack because quill gets initialized twice
    $(this.element).find('.ql-toolbar').remove();

    this.quill = new Quill(this.containerTarget, {
      theme: 'snow',
      placeholder: this.element.dataset.placeholder,
      modules: {
        toolbar: [
          [{'header':[]}],
          ['bold', 'italic', 'underline', 'strike', {'color': []}],
          [{'list': 'ordered'}, {'list': 'bullet'}],
          ['image', 'link'],
          ['clean']
        ]
      }
    });

    this.quill.on('text-change', () => {
      $(this.element).find('input').val(this.quill.root.innerHTML);
    });
  }
}
