class CranesController < ApplicationController
  include Pundit::Authorization
  require 'caxlsx'
  
  before_action :set_crane, only: [:show, :edit, :update, :destroy, :serial_numbers]
  before_action :set_crane_owners, only: [:new, :edit]

  def index
    @cranes = policy_scope(Crane)
    authorize Crane
  
    @cranes = if params[:search].present?
      @cranes.where("
        crane_brand_name ILIKE :search OR 
        crane_model_name ILIKE :search OR 
        crane_chassis_no ILIKE :search OR 
        crane_year::text ILIKE :search OR
        crane_chassis_size ILIKE :search OR
        crane_mast_size ILIKE :search OR
        crane_height::text ILIKE :search OR
        crane_boom_length::text ILIKE :search OR
        crane_tonnage::text ILIKE :search OR
        crane_boom_tonnage::text ILIKE :search
      ", search: "%#{params[:search]}%")
    else
      @cranes
    end
  
    @cranes = @cranes.order(created_at: :desc)
  
    respond_to do |format|
      format.html
      format.xlsx do
        authorize Crane, :export?
        response.headers['Content-Disposition'] = 'attachment; filename="cranes.xlsx"'
      end
    end
  end

  def show
    @crane = Crane.find(params[:id])
    authorize @crane
    
    respond_to do |format|
      format.html { redirect_to cranes_path }
      format.json { 
        # Debug için
        Rails.logger.debug "Crane Data: #{@crane.attributes.inspect}"
        Rails.logger.debug "Crane Fixing: #{@crane.crane_fixing.inspect if @crane.crane_fixing}"
        
        render json: {
          crane_fixing: @crane.crane_fixing&.attributes,
          crane_chassis_size: @crane.crane_chassis_size,
          crane_mast_size: @crane.crane_mast_size,
          crane_height: @crane.crane_height,
          crane_boom_length: @crane.crane_boom_length,
          crane_tonnage: @crane.crane_tonnage,
          crane_boom_tonnage: @crane.crane_boom_tonnage
        }
      }
    end
  end

  def new
    @crane = Crane.new
    authorize @crane
  end

  def create
    @crane = Crane.new(crane_params)
    authorize @crane
    
    if @crane.save
      redirect_to cranes_path, notice: "Vinç başarıyla kaydedildi."
    else
      set_crane_owners
      render :new, status: :unprocessable_entity, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def edit
    authorize @crane
  end

  def update
    authorize @crane
    
    if @crane.update(crane_params)
      redirect_to cranes_path, notice: "Vinç başarıyla güncellendi."
    else
      set_crane_owners
      render :edit, status: :unprocessable_entity, alert: "Bir hata oluştu. Tekrar deneyin."
    end
  end

  def destroy
    authorize @crane
    @crane.destroy
    redirect_to cranes_path, notice: "Vinç başarıyla silindi."
  end

  def serial_numbers
    authorize @crane, :show?
    render json: { serial_numbers: @crane.serial_numbers }
  end

  def info
    crane = Crane.find(params[:id])
    render json: {
    crane_height: crane.crane_height,
    crane_boom_length: crane.crane_boom_length,
    crane_tonnage: crane.crane_tonnage
    }
  end

  def import
    if params[:file].present?
      begin
        spreadsheet = Roo::Spreadsheet.open(params[:file].path)
        header = spreadsheet.row(1)
        
        (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
          
          crane = Crane.new(
            crane_brand_name: row['Marka'],
            crane_model_name: row['Model'],
            crane_chassis_no: row['Şase No'],
            crane_year: row['Yıl'],
            crane_chassis_size: row['Şase Boyutu'],
            crane_mast_size: row['Mast Boyutu'],
            crane_height: row['Yükseklik'],
            crane_boom_length: row['Bom Uzunluğu'],
            crane_tonnage: row['Kapasite'],
            crane_boom_tonnage: row['Bom Ucu Kapasitesi'],
            crane_owner_id: CraneOwner.find_by(crane_owner_name: row['Vinç Firması'])&.id
          )
          
          if crane.save
            next
          else
            flash[:error] = "Satır #{i}: #{crane.errors.full_messages.join(', ')}"
            redirect_to cranes_path
            return
          end
        end
        
        flash[:success] = { 
          title: "Excel Yükleme Başarılı", 
          message: "Vinçler başarıyla içe aktarıldı.", 
          filename: params[:file].original_filename 
        }
      rescue => e
        flash[:error] = "Hata oluştu: #{e.message}"
      end
    else
      flash[:error] = "Lütfen bir dosya seçin"
    end
    
    redirect_to cranes_path
  end

  def download_template
    p = Axlsx::Package.new
    wb = p.workbook
    
    wb.add_worksheet(name: "Vinçler") do |sheet|
      # Başlık satırı stilleri
      title_style = wb.styles.add_style(
        bg_color: "CCCCCC",
        fg_color: "000000",
        b: true,
        alignment: { horizontal: :center }
      )
      
      # Başlık satırı
      headers = [
        'Marka',
        'Model',
        'Şase No',
        'Yıl',
        'Şase Boyutu',
        'Mast Boyutu',
        'Yükseklik',
        'Bom Uzunluğu',
        'Kapasite',
        'Bom Ucu Kapasitesi',
        'Vinç Firması'
      ]
      
      sheet.add_row headers, style: title_style
      
      # Örnek veri satırı
      example_data = [
        'Liebherr',
        'LTM 1100',
        'ABC123',
        '2020',
        '10x10',
        '15x15',
        '50',
        '40',
        '1000',
        '500',
        'Örnek Firma A.Ş.'
      ]
      
      sheet.add_row example_data
      
      # Sütun genişliklerini ayarla
      sheet.column_widths 15, 15, 15, 10, 15, 15, 12, 12, 12, 15, 20
    end
    
    send_data(
      p.to_stream.read,
      filename: "vinc_sablonu.xlsx",
      type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )
  end

  private

  def set_crane
    @crane = Crane.find(params[:id])
  end

  def set_crane_owners
    @crane_owners = CraneOwner.all
  end

  def crane_params
    params.require(:crane).permit(
      :crane_brand_name, 
      :crane_model_name, 
      :crane_chassis_no, 
      :crane_boom_length, 
      :crane_height, 
      :crane_tonnage, 
      :crane_boom_tonnage, 
      :crane_year, 
      :crane_owner_id, 
      :available
    )
  end

  def pundit_user
    current_user
  end

  def user_not_authorized
    flash[:alert] = "Bu işlemi yapmaya yetkiniz yok."
    redirect_to(request.referrer || cranes_path)
  end
end