require Rails.root.join('lib/tools', 'make_calcs.rb')

class TempTransactionsController < ApplicationController
  before_action :set_temp_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_charts, only: [:new,:edit,:create,:update]
  # GET /temp_transactions
  # GET /temp_transactions.json
  def index
    @temp_transactions = TempTransaction.where("users_id = ?",current_user.id)
    @chart_clones = ChartClone.all
    @partcharts = Chart.where("users_id = ? and glcode = ? and header = ?" , current_user.id, ChartClone.last.id,0)
     respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @temp_transactions }
    end
  end
  def indexfull
    @sd = Datesetting.where("users_id = ?", current_user.id)
    @ed = Datesetting.where("users_id = ?", current_user.id)
    # byebug
    @temp_transactions = TempTransaction.where("date >= ? and date <= ?", @sd.first.startdate, @ed.first.enddate)
    @chart_clones = ChartClone.all
    @partcharts = Chart.where("glcode = ?  and header = ?" , ChartClone.last.id,0)

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @temp_transactions }
    end
  end
  # GET /temp_transactions/1
  # GET /temp_transactions/1.json
  def show
  end

  # GET /temp_transactions/new
  def new
    @temp_transaction = TempTransaction.new
    @chart_clones = ChartClone.all
    @partcharts = Chart.where("users_id = ? and glcode = ?  and header = ?" , current_user.id, ChartClone.last.id,0).order("code")
    @megatrans = @temp_transaction
  end

  # GET /temp_transactions/1/edit
  def edit
    @chart_clones = ChartClone.all
    if @temp_transaction.chart_clones_id != nil
      glc = ChartClone.where("id = ?", @temp_transaction.chart_clones_id).last.id
      @partcharts = Chart.where("users_id = ? and glcode = ?" , current_user.id, glc).order("code")
    else
      @partcharts = Chart.where("users_id = ? and glcode = ?" , current_user.id, 6).order("code")
    end
    @megatrans = @temp_transaction
  end

  # POST /temp_transactions
  # POST /temp_transactions.json
  def create
    if params[:transaction_ids].nil? || params[:transaction_ids].empty? 
      @temp_transaction = TempTransaction.new(temp_transaction_params)
      @temp_transaction.users_id = current_user.id
      make_calcs(@temp_transaction,temp_transaction_params)
      respond_to do |format|
        if @temp_transaction.save
          format.html { redirect_to @temp_transaction, notice: 'Temp transaction was successfully created.' }
          format.json { render :show, status: :created, location: @temp_transaction }
        else
          format.html { render :new }
          format.json { render json: @temp_transaction.errors, status: :unprocessable_entity }
        end
      end
    else
      @temp_transactions = TempTransaction.where(id: params[:transaction_ids])
      @temp_transactions.each do |mitem|
        @transaction = Transaction.new
        @transaction.users_id = current_user.id
        # byebug
        if  mitem.amounttotal < 0
          @transaction.amounttotal = mitem.amounttotal * (-1)
          @transaction.netamount = mitem.netamount * (-1)
          if mitem.gstamount != nil
            @transaction.gstamount = mitem.gstamount * (-1)
          else 
            @transaction.gstamount = 0
          end
        else
          @transaction.amounttotal = mitem.amounttotal
          @transaction.netamount = mitem.netamount
          if mitem.gstamount != nil
            @transaction.gstamount = mitem.gstamount
          else
            @transaction.gstamount = 0
          end
        end
        
        @transaction.chart_clones_id = mitem.chart_clones_id
        @transaction.code = mitem.code
        @transaction.gsttype = mitem.gsttype
        @transaction.gst_include = mitem.gst_include
        @transaction.co = mitem.co
        @transaction.date = mitem.date
        @transaction.save
        mitem.destroy
      end
    end
    
  end

  # PATCH/PUT /temp_transactions/1
  # PATCH/PUT /temp_transactions/1.json
  def update
    @temp_transaction.update(temp_transaction_params)
    @temp_transaction.users_id=current_user.id
    make_calcs(@temp_transaction,temp_transaction_params)

    respond_to do |format|
      if @temp_transaction.update(temp_transaction_params)
        format.html { redirect_to @temp_transaction, notice: 'Temp transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @temp_transaction }
      else
        format.html { render :edit }
        format.json { render json: @temp_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_transactions/1
  # DELETE /temp_transactions/1.json
  def destroy
    @temp_transaction.destroy
    respond_to do |format|
      format.html { redirect_to temp_transactions_url, notice: 'Temp transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_cur_codes
  
   @partcharts = Chart.where("users_id = ? and glcode = ? and header = ?" , current_user.id, params[:chart_clones_id],0)
   respond_to do |format|
     format.js
   end
  end

  def clean_up
    @sd = Datesetting.where("users_id = ?", current_user.id)
    @ed = Datesetting.where("users_id = ?", current_user.id)
    @temp_transactions = TempTransaction.where("date >= ? and date <= ? and users_id = ?", @sd.first.startdate, @ed.first.enddate, current_user.id)
    # byebug
    @temp_transactions.destroy_all
    # byebug
    respond_to do |format|
      format.html { redirect_to temp_transactions_url, notice: 'Table temp transactions was successfully cleaned up.' }
      format.json { head :no_content }
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_transaction
      @temp_transaction = TempTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def temp_transaction_params
      params.require(:temp_transaction).permit(:amounttotal, :date, :what, :who, :co, :chart_clones_id, :code, :users_id, :gsttype, :netamount, :gstamount, :gst_include) 
    end
   
    def set_charts
      @chart_clones = ChartClone.all
      @partcharts = Chart.where("users_id = ? and glcode = ?" , current_user.id, ChartClone.last.id)       
    end     
   
end
