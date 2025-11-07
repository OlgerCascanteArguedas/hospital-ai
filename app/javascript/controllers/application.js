import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// Auto-cierra flashes en 5s
const setupFlashAutoDismiss = () => {
  const flashes = document.querySelectorAll('.alert, .notice, .alert-success, .alert-danger');
  flashes.forEach((el) => {
    if (el.dataset.autodismissAttached) return; // evitar duplicar timers
    el.dataset.autodismissAttached = "true";

    setTimeout(() => {
      if (el.classList.contains('fade')) {
        el.classList.remove('show');      // animación Bootstrap
        setTimeout(() => el.remove(), 350);
      } else {
        el.remove();
      }
    }, 5000); // 5 segundos
  });
};

document.addEventListener('turbo:load', setupFlashAutoDismiss);
document.addEventListener('DOMContentLoaded', setupFlashAutoDismiss);
