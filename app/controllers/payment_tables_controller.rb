class PaymentTablesController < ApplicationController
  def update
    @payment_table = PaymentTable.find(params[:id])
    
    # Debug için parametre kontrolü
    Rails.logger.debug "Gelen parametreler: #{params.inspect}"
    
    if params[:payment_table][:file].present?
      # Dosya yükleme işlemi
      if @payment_table.file.attach(params[:payment_table][:file])
        flash[:success] = {
          title: "Dosya Yüklendi!",
          filename: params[:payment_table][:file].original_filename,
          message: "Dosya başarıyla yüklenmiştir."
        }
      else
        flash[:alert] = "Dosya yüklenemedi."
      end

      respond_to do |format|
        format.html { redirect_to contract_path(@payment_table.contract) }
        format.js { 
          render js: <<-JS
            document.querySelector('#uploadModal#{@payment_table.id}').querySelector('.btn-close').click();
            window.location.reload();
          JS
        }
      end
      
    elsif params[:payment_table][:payment_method_id].present?
      # Ödeme yöntemi güncelleme işlemi
      if @payment_table.update(payment_table_params)
        flash[:notice] = "Ödeme yöntemi güncellendi."
      else
        flash[:alert] = "Ödeme yöntemi güncellenemedi."
      end
      redirect_to contract_path(@payment_table.contract)
    elsif params[:payment_table][:note].present? || params[:payment_table][:note] == ""
      if @payment_table.update(note_params)
        respond_to do |format|
          format.html { 
            flash[:notice] = "Not güncellendi"
            redirect_to contract_path(@payment_table.contract)
          }
          format.json { render json: { status: 'success', message: 'Not güncellendi' } }
        end
      else
        respond_to do |format|
          format.html {
            flash[:alert] = "Not güncellenemedi"
            redirect_to contract_path(@payment_table.contract)
          }
          format.json { render json: { status: 'error', message: 'Not güncellenemedi' } }
        end
      end
    end
  end

  def delete_file
    @payment_table = PaymentTable.find(params[:id])
    
    if @payment_table.file.attached?
      @payment_table.file.purge
      redirect_to contract_path(@payment_table.contract), notice: 'Dosya başarıyla silindi.'
    else
      redirect_to contract_path(@payment_table.contract), alert: 'Dosya bulunamadı.'
    end
  rescue => e
    redirect_to contract_path(@payment_table.contract), alert: 'Dosya silinirken bir hata oluştu.'
  end

  def send_payment_email
    @payment = PaymentTable.find(params[:id])
    
    # Debug logları ekleyelim
    Rails.logger.debug "Payment Email Debug: Starting process"
    Rails.logger.debug "Payment ID: #{@payment.id}"
    Rails.logger.debug "Contract: #{@payment.contract.inspect}"
    Rails.logger.debug "Customer: #{@payment.contract.customer.inspect}"
    Rails.logger.debug "Customer Email: #{@payment.contract.customer.email}"
    
    begin
      customer = @payment.contract.customer
      
      if !customer
        flash[:alert] = 'Müşteri bilgisi bulunamadı!'
        Rails.logger.error "Payment Email Error: Customer not found"
        return redirect_to contract_path(@payment.contract)
      end
      
      if !customer.email.present?
        flash[:alert] = 'Müşterinin email adresi bulunamadı!'
        Rails.logger.error "Payment Email Error: Customer email is blank"
        return redirect_to contract_path(@payment.contract)
      end
  
      # Mailer'ı çağırmadan önce kontrol
      Rails.logger.debug "Preparing to send email to: #{customer.email}"
      
      # Mailer'ı çağır
      mail = PaymentMailer.payment_notification(@payment)
      Rails.logger.debug "Mailer object created: #{mail.inspect}"
      
      # Email'i gönder
      result = mail.deliver_now
      Rails.logger.debug "Email delivery result: #{result.inspect}"
      
      # Başarılı gönderim sonrası
      @payment.update!(email_sent_at: Time.current)
      flash[:notice] = 'Email başarıyla gönderildi.'
      
    rescue => e
      error_message = "Email gönderme hatası: #{e.message}"
      Rails.logger.error error_message
      Rails.logger.error e.backtrace.join("\n")
      flash[:error] = "Email gönderilemedi: #{e.message}"
    end
  
    redirect_to contract_path(@payment.contract)
  end

  private

  def payment_table_params
    params.require(:payment_table).permit(:payment_method_id, :file)
  end


  def note_params 
    params.require(:payment_table).permit(:note)
  end

  def handle_note_update
    if @payment_table.update(note_params)
      respond_to do |format|
        format.html { 
          flash[:notice] = "Not güncellendi"
          redirect_to contract_path(@payment_table.contract)
        }
        format.json { 
          render json: { status: 'success', message: 'Not güncellendi' }
        }
      end
    else
      respond_to do |format|
        format.html {
          flash[:alert] = "Not güncellenemedi"
          redirect_to contract_path(@payment_table.contract)
        }
        format.json { 
          render json: { status: 'error', message: 'Not güncellenemedi' }
        }
      end
    end
  end
end
