import { Controller } from "stimulus"
import consumer from '../channels/consumer'

export default class extends Controller {
  static targets = [ 'content', 'launchButton', 'notesField' ]

  connect() {
    this.windowId = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    this.subscription = consumer.subscriptions.create('NarratorChannel', {
      connected: () => {
        $(this.launchButtonTargets).show()
      },
      received: (data) => {
        $(this.contentTarget).html(data);
      }
    });

    this.debounceNotes = null;
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

  onLaunchDemo(e) {
    $(this.element).addClass('with-session').addClass('launched');
    this.openScreen(e.target.dataset.url);
  }

  onLaunch(e) {
    $(this.element).removeClass('with-session').addClass('launched');
    this.openScreen(e.target.dataset.url);
  }

  onJump(e) {
    const $select = $(e.target);
    const url = $select.val();
    $select.val('');
    this.openScreen(url);
  }

  onNotes() {
    this.saveNotes();
  }

  onEndDemo(e) {
    $(e.target).html('Saving...');
    this.saveNotes(e.target.dataset.url);
  }

  saveNotes(redirect=null) {
    clearTimeout(this.debounceNotes);
    this.debounceNotes = setTimeout(() => {
      console.log('here');
      $.post({
        url: this.notesFieldTarget.dataset.url,
        data: { notes: $(this.notesFieldTarget).val() },
        complete: () => {
          if (redirect !== null) {
            window.location = redirect;
          }
        }
      });
    }, redirect === null ? 50 : 0);
  }

  openScreen(url) {
    window.open(url, 'mongo-narrator', 'location=no');
  }
}
