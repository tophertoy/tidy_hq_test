import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
  }

  copy(event) {
    const button = event.currentTarget;
    const urlToCopy = this.getUrl(button);
    this.copyToClipboard(urlToCopy, button);
  }

  getUrl(button) {
    return button.dataset.url;
  }

  copyToClipboard(url, button) {
    navigator.clipboard.writeText(url)
      .then(() => this.provideFeedback(button))
      .catch((err) => this.handleError(err));
  }

  provideFeedback(button) {
    this.changeButtonText(button, "Copied!");
    this.disableButton(button);
    this.resetButtonAfterDelay(button);
  }

  changeButtonText(button, message) {
    button.textContent = message;
  }

  disableButton(button) {
    button.disabled = true;
  }

  resetButtonAfterDelay(button) {
    setTimeout(() => {
      this.changeButtonText(button, "Copy");
      button.disabled = false;
    }, 2000);
  }

  handleError(error) {
    console.error('Failed to copy!', error);
  }
}
