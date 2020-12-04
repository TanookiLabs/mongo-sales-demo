import { Controller } from "stimulus"
import consumer from '../channels/consumer'

export default class extends Controller {
  static targets = [ 'content', 'launchButton' ]

  initialize() {
    this.windowId = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    this.subscription = consumer.subscriptions.create('NarratorChannel', {
      connected: () => {
        console.log('connected');
        $(this.launchButtonTarget).show()
      },
      received: (data) => {
        $(this.contentTarget).html(data);
      }
    });
  }

//   connect() {
//   }
//
//   disconnect() {
//     console.log('disconnecting');
//     this.subscription.unsubscribe();
//   }

  onLaunch(e) {
    this.openScreen(e.target.dataset.url);
  }

  onJump(e) {
    const $select = $(e.target);
    const url = $select.val();
    $select.val('');
    this.openScreen(url);
  }

  openScreen(url) {
    window.open(url, 'mongo-narrator', 'location=no');
  }
}
