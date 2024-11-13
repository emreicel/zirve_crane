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
  