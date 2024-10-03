import { Application } from "@hotwired/stimulus"
import ClipboardController from "./clipboard_controller"

const application = Application.start()
application.register("clipboard", ClipboardController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
