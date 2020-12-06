import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'img', 'imageUrl', 'salesItem', 'emptySalesItem', 'salesItemsList' ]

  onUploadImage(e) {
    e.preventDefault();

    filestack_client.picker({
      uploadInBackground: false,
      onUploadDone: this.uploadComplete.bind(this)
    }).open();
  }

  onAddSalesItem(e) {
    const $newEntry = $('<div class="m-admin-screen-sales-item" data-target="screen-edit.salesItem" data-controller="sales-item-edit"></div>');
    $newEntry.append($(this.emptySalesItemTarget).clone().data('target', '').show());
    $(this.salesItemsListTarget).append($newEntry);
  }

  onSave(e) {
    e.preventDefault();

    for (const [i, v] of this.salesItemTargets.entries()) {
      const fieldPrefix = `screen[sales_items_attributes[${i}]`
      $(v).find('input,textarea').each((i, el) => {
        const $el = $(el);
         $el.attr('name', $el.attr('name').replace(/screen\[sales_items_attributes\]\[\d?\]/, fieldPrefix));
      });
    }

    $(this.element).find('form').submit();
  }

  uploadComplete(files) {
    if (files.filesUploaded.length === 1) {
      const url = files.filesUploaded[0].url;
      $(this.imgTarget).attr('src', url).show();
      $(this.imageUrlTarget).val(url);
    }
  }
}
