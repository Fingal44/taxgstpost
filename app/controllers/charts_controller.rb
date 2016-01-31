# require_dependency "custombibl.rb"

class ChartsController < ApplicationController
 before_filter :authenticate_user!
 before_filter :set_chart, only: [:show, :edit, :update, :destroy]
  
  # GET /charts
  # GET /charts.json
  def index
    # @trd=TransferData.all
    if current_user == nil  
      @charts = Chart.where("users_id = 0").order("code")
    else
      @charts = Chart.where("users_id = ?",current_user.id).order("code")
    end

    respond_to do |format|
     # format.html # index.html.erb
      format.html # index.html.haml
      format.json { render json: @charts }
    end
  end
 
  def indexfull
    #cu=current_user.id
    if current_user == nil  
      @charts = Chart.where("users_id = 0").order("code")
    else
      @charts = Chart.all.order("users_id","code")
    end

    respond_to do |format|
     # format.html # index.html.erb
      format.html # index.html.haml
      format.json { render json: @charts }
    end
  end
  # GET /charts/1
  # GET /charts/1.json
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @chart }
    end
  end

  # GET /charts/new
  # GET /charts/new.json
  def new
    @chart = Chart.new

    respond_to do |format|
      # format.html # new.html.erb
      format.html # new.html.haml
      format.json { render json: @chart }
    end
  end

  # GET /charts/1/edit
  def edit
   
  end

  # POST /charts
  # POST /charts.json
  def create
    @chart = Chart.new(chart_params)
    @chart.user = current_user.id
    @chart.amount_1 = 0
    @chart.amount_2 = 0
    respond_to do |format|
      if @chart.save
        
        format.html { redirect_to @chart, notice: 'Chart was successfully created.' }
        format.json { render json: @chart, status: :created, location: @chart }
      else
        format.html { render action: "new" }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charts/1
  # PUT /charts/1.json
  def update
    byebug
    respond_to do |format|
      if @chart.update(chart_params)
        format.html { redirect_to @chart, notice: 'Chart was successfully updated.' }
        format.json {render :show, status: :ok, location: @chart}
      else
        format.html { render action: "edit" }
        format.json { render json: @chart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charts/1
  # DELETE /charts/1.json
  def destroy
#    @chart = Chart.find(params[:id])
    @chart.destroy

    respond_to do |format|
      format.html { redirect_to charts_url }
      format.json { head :no_content }
    end
  end
  
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_chart
      @chart = Chart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chart_params
      params.require(:chart).permit(:code, :content, :glcode, :gst, :header, :users_id, :args)
    end
end
