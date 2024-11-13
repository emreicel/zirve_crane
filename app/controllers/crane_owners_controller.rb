class CraneOwnersController < ApplicationController
  before_action :set_crane_owner, only: [:show, :edit, :update, :destroy]
  
  # GET /crane_owners or /crane_owners.json
  def index
    @crane_owners = CraneOwner.all
  end

  # GET /crane_owners/1 or /crane_owners/1.json
  def show
  end

  # GET /crane_owners/new
  def new
    @crane_owner = CraneOwner.new
  end

  # GET /crane_owners/1/edit
  def edit
  end

  # POST /crane_owners or /crane_owners.json
  def create
    @crane_owner = CraneOwner.new(crane_owner_params)

    respond_to do |format|
      if @crane_owner.save
        format.html { redirect_to @crane_owner, notice: "Crane owner was successfully created." }
        format.json { render :show, status: :created, location: @crane_owner }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crane_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crane_owners/1 or /crane_owners/1.json
  def update
    respond_to do |format|
      if @crane_owner.update(crane_owner_params)
        format.html { redirect_to @crane_owner, notice: "Crane owner was successfully updated." }
        format.json { render :show, status: :ok, location: @crane_owner }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crane_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crane_owners/1 or /crane_owners/1.json
  def destroy
    @crane_owner.destroy!

    respond_to do |format|
      format.html { redirect_to crane_owners_path, status: :see_other, notice: "Crane owner was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crane_owner
      @crane_owner = CraneOwner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def crane_owner_params
      params.require(:crane_owner).permit(:crane_owner_name, :crane_owner_address, :crane_owner_phone, :crane_owner_vat_office, :crane_owner_contact, :crane_owner_contact_email, :crane_owner_contact_phone)
    end
end
