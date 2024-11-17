class PaymentTable < ApplicationRecord
  belongs_to :contract
  belongs_to :payment_method, optional: true
  has_one_attached :file
  
  
  # Dosya türü validasyonu
  validate :acceptable_file
  
  private
  
  def acceptable_file
    return unless file.attached?
    
    unless file.byte_size <= 10.megabyte
      errors.add(:file, 'dosya boyutu 10MB\'dan küçük olmalıdır')
    end
    
    acceptable_types = ['application/pdf', 
                       'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                       'application/vnd.ms-excel',
                       'application/msword',
                       'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
                       
    unless acceptable_types.include?(file.content_type)
      errors.add(:file, 'kabul edilen dosya formatları: PDF, XLSX, XLS, DOC, DOCX')
    end
  end

  def log_file_attachment
    Rails.logger.info "Dosya ekleme durumu: #{file.attached?}" if file.attached?
  end
  
end