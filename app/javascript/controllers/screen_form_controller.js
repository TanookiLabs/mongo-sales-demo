import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'img', 'imageUrl' ]

  onUploadImage(e) {
    e.preventDefault();

    filestack_client.picker({
      uploadInBackground: false,
      onUploadDone: this.uploadComplete.bind(this)
    }).open();
  }

  uploadComplete(files) {
    if (files.filesUploaded.length === 1) {
      const url = files.filesUploaded[0].url;
      $(this.imgTarget).attr('src', url).show();
      $(this.imageUrlTarget).val(url);
    }
  }
}
