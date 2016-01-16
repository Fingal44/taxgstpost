class DatesettingsController < ApplicationController
  before_action :set_datesetting, only: [:show, :edit, :update, :destroy]

  # GET /datesettings
  # GET /datesettings.json
  def index
    @datesettings = Datesetting.where("users_id = ?", current_user.id)
  end

  # GET /datesettings/1
  # GET /datesettings/1.json
  def show
  end

  # GET /datesettings/new
  def new
    @datesetting = Datesetting.new
  end

  # GET /datesettings/1/edit
  def edit
  end

  # POST /datesettings
  # POST /datesettings.json
  def create
    @datesetting = Datesetting.new(datesetting_params)
    @datesetting.users_id = current_user.id
    respond_to do |format|
      if @datesetting.save
        format.html { redirect_to @datesetting, notice: 'Datesetting was successfully created.' }
        format.json { render :show, status: :created, location: @datesetting }
      else
        format.html { render :new }
        format.json { render json: @datesetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datesettings/1
  # PATCH/PUT /datesettings/1.json
  def update
    respond_to do |format|
      if @datesetting.update(datesetting_params)
        format.html { redirect_to @datesetting, notice: 'Datesetting was successfully updated.' }
        format.json { render :show, status: :ok, location: @datesetting }
      else
        format.html { render :edit }
        format.json { render json: @datesetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datesettings/1
  # DELETE /datesettings/1.json
  def destroy
    @datesetting.destroy
    respond_to do |format|
      format.html { redirect_to datesettings_url, notice: 'Datesetting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datesetting
      @datesetting = Datesetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datesetting_params
      params[:datesetting]
      params.require(:datesetting).permit(:startdate,:enddate, :users_id)
    end
end
