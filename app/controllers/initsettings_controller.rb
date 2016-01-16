class InitsettingsController < ApplicationController
  before_action :set_initsetting, only: [:show, :edit, :update, :destroy]

  # GET /initsettings
  # GET /initsettings.json
  def index
    @initsettings = Initsetting.all
  end

  # GET /initsettings/1
  # GET /initsettings/1.json
  def show
  end

  # GET /initsettings/new
  def new
    @initsetting = Initsetting.new
  end

  # GET /initsettings/1/edit
  def edit
  end

  # POST /initsettings
  # POST /initsettings.json
  def create
    @initsetting = Initsetting.new(initsetting_params)

    respond_to do |format|
      if @initsetting.save
        format.html { redirect_to @initsetting, notice: 'Initsetting was successfully created.' }
        format.json { render :show, status: :created, location: @initsetting }
      else
        format.html { render :new }
        format.json { render json: @initsetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /initsettings/1
  # PATCH/PUT /initsettings/1.json
  def update
    respond_to do |format|
      if @initsetting.update(initsetting_params)
        format.html { redirect_to @initsetting, notice: 'Initsetting was successfully updated.' }
        format.json { render :show, status: :ok, location: @initsetting }
      else
        format.html { render :edit }
        format.json { render json: @initsetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /initsettings/1
  # DELETE /initsettings/1.json
  def destroy
    @initsetting.destroy
    respond_to do |format|
      format.html { redirect_to initsettings_url, notice: 'Initsetting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_initsetting
      @initsetting = Initsetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def initsetting_params
      params[:initsetting]
      params.require(:initsetting).permit(:periodint,:periodtext)
    end
end
