// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "controllers"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.start()
import { Application } from "@hotwired/stimulus"
import Rails from "@rails/ujs"
import PaymentController from "./controllers/payment_controller"
Rails.start()

const application = Application.start()
application.register("payment", PaymentController)

function toggleSettingsMenu() {
    const menu = document.getElementById('settings-menu');
    menu.classList.toggle('d-none');
}

// Dosya yükleme başarılı olduğunda modal'ı kapatıp sayfayı yenile
document.addEventListener('ajax:success', function(event) {
    if (event.detail[0].success) {
        const modalElement = event.target.closest('.modal');
        if (modalElement) {
            const modal = bootstrap.Modal.getInstance(modalElement);
            modal.hide();
            window.location.reload();
        }
    }
});

document.addEventListener('turbo:load', function() {
    document.querySelectorAll('select[onchange]').forEach(select => {
      select.addEventListener('change', function() {
        this.disabled = true;
        this.parentElement.classList.add('opacity-50');
        
        // Form submit olduktan sonra
        this.form.addEventListener('ajax:success', () => {
          this.disabled = false;
          this.parentElement.classList.remove('opacity-50');
        });
      });
    });
}); 