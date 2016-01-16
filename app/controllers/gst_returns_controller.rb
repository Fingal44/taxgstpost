class GstReturnsController < ApplicationController
  before_action :set_gst_return, only: [:show, :edit, :update, :destroy]

  # GET /gst_returns
  # GET /gst_returns.json
  def index
    @gst_returns = GstReturn.all
  end

  # GET /gst_returns/1
  # GET /gst_returns/1.json
  def show
  end

  # GET /gst_returns/new
  def new
    @gst_return = GstReturn.new
  end

  # GET /gst_returns/1/edit
  def edit
  end

  # POST /gst_returns
  # POST /gst_returns.json
  def create
    @gst_return = GstReturn.new(gst_return_params)

    respond_to do |format|
      if @gst_return.save
        format.html { redirect_to @gst_return, notice: 'Gst return was successfully created.' }
        format.json { render :show, status: :created, location: @gst_return }
      else
        format.html { render :new }
        format.json { render json: @gst_return.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gst_returns/1
  # PATCH/PUT /gst_returns/1.json
  def update
    respond_to do |format|
      if @gst_return.update(gst_return_params)
        format.html { redirect_to @gst_return, notice: 'Gst return was successfully updated.' }
        format.json { render :show, status: :ok, location: @gst_return }
      else
        format.html { render :edit }
        format.json { render json: @gst_return.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gst_returns/1
  # DELETE /gst_returns/1.json
  def destroy
    @gst_return.destroy
    respond_to do |format|
      format.html { redirect_to gst_returns_url, notice: 'Gst return was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gst_return
      @gst_return = GstReturn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gst_return_params
      params[:gst_return]
    end
end
