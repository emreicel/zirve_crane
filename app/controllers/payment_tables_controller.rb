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
    
    begin
      if @payment.contract.customer.email.present?
        PaymentMailer.payment_notification(@payment).deliver_now # deliver_later yerine deliver_now kullanalım test için
        flash[:notice] = 'Email başarıyla gönderildi.'
      else
        flash[:alert] = 'Müşterinin email adresi bulunamadı!'
      end
    rescue => e
      flash[:error] = "Email gönderilirken hata oluştu: #{e.message}"
      Rails.logger.error("Email gönderme hatası: #{e.message}")
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
