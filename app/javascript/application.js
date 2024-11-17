// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "controllers"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.start()
import { Application } from "@hotwired/stimulus"
import Rails from "@rails/ujs"
Rails.start()

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
  