import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  saveNote(event) {
    const textarea = event.target
    const form = textarea.closest('form')
    
    // Debounce işlemi için
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const formData = new FormData(form)
      
      // CSRF token'ı al
      const token = document.querySelector('meta[name="csrf-token"]').content
      
      fetch(form.action, {
        method: 'PATCH',
        headers: {
          'X-CSRF-Token': token,
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        },
        body: formData
      })
      .then(response => response.json())
      .then(data => {
        if (data.status === 'success') {
          // Başarılı kayıt göstergesi
          textarea.classList.add('is-valid')
          setTimeout(() => textarea.classList.remove('is-valid'), 2000)
        } else {
          // Hata göstergesi
          textarea.classList.add('is-invalid')
          setTimeout(() => textarea.classList.remove('is-invalid'), 2000)
        }
      })
      .catch(error => {
        console.error('Error:', error)
        textarea.classList.add('is-invalid')
        setTimeout(() => textarea.classList.remove('is-invalid'), 2000)
      })
    }, 500)
  }
}