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

  private

  def payment_table_params
    params.require(:payment_table).permit(:payment_method_id, :file)
  end
end