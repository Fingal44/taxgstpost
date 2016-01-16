require Rails.root.join('lib/tools', 'make_calcs.rb')

class FutureTransactionsController < ApplicationController
  before_action :set_future_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_charts, only: [:new,:edit,:create,:update]
  # GET /future_transactions
  # GET /future_transactions.json
  def index
    @future_transactions = FutureTransaction.where("users_id = ?",current_user.id)
    @chart_clones = ChartClone.all
    @partcharts = Chart.where("users_id = ? and glcode = ? and header = ?" , current_user.id, ChartClone.last.id,0)
     respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @future_transactions }
     end 
  end

  # GET /future_transactions/1
  # GET /future_transactions/1.json
  def show
  end

  # GET /future_transactions/new
  def new
    @future_transaction = FutureTransaction.new
    @chart_clones = ChartClone.all
    @partcharts = Chart.where("users_id = ? and glcode = ?  and header = ?" , current_users_id.id, ChartClone.last.id,0)
    @megatrans = @future_transaction
  end

  # GET /future_transactions/1/edit
  def edit
    @chart_clones = ChartClone.all
    glc = ChartClone.where("id = ?", @future_transaction.chart_clones_id).last.id
    @partcharts = Chart.where("users_id = ? and glcode = ?" , current_user.id, glc)
    @megatrans = @future_transaction
  end

  # POST /future_transactions
  # POST /future_transactions.json
  def create
    # byebug
    if params[:transaction_ids].nil? || params[:transaction_ids].empty? 
      @future_transaction = FutureTransaction.new(future_transaction_params)
      @future_transaction.users_id = current_user.id
      make_calcs(@future_transaction,future_transaction_params)
      respond_to do |format|
        if @future_transaction.save
          format.html { redirect_to @future_transaction, notice: 'Future transaction was successfully created.' }
          format.json { render :show, status: :created, location: @future_transaction }
        else
          format.html { render :new }
          format.json { render json: @future_transaction.errors, status: :unprocessable_entity }
        end
      end
     else
       @future_transactions = FutureTransaction.where(id: params[:transaction_ids])
       # byebug
       @future_transactions.each do |mitem|
          @transaction = Transaction.new
          @transaction.users_id = current_user.id
          @transaction.amounttotal = mitem.amounttotal
          @transaction.netamount = mitem.netamount
          @transaction.chart_clones_id = mitem.chart_clones_id
          @transaction.chart_id = mitem.code
          @transaction.gsttype = 0
          @transaction.co = mitem.co
          @transaction.date = DateTime.now
          @transaction.save
          mitem.destroy
        end
     end
  end

  # PATCH/PUT /future_transactions/1
  # PATCH/PUT /future_transactions/1.json
  def update
    @future_transaction.update(future_transaction_params)
    make_calcs(@future_transaction,future_transaction_params)
    respond_to do |format|
      if @future_transaction.update(future_transaction_params)
        format.html { redirect_to @future_transaction, notice: 'Future transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @future_transaction }
      else
        format.html { render :edit }
        format.json { render json: @future_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /future_transactions/1
  # DELETE /future_transactions/1.json
  def destroy
    @future_transaction.destroy
    respond_to do |format|
      format.html { redirect_to future_transactions_url, notice: 'Future transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def update_curf_codes
  
   @partcharts = Chart.where("users_id = ? and glcode = ? and header = ?" , current_user.id, params[:chart_clones_id],0)
 # byebug
   respond_to do |format|
     format.js
   end
  end

  def compact
    @ft_for = FutureTransaction.where("users_id = ?",current_user.id).order('code','created_at')
    @ft_for.each do |tr|
      _code = tr.amounttotal
      _chid = tr.code
      _ft_for = @ft_for.where("code = ?",_chid).order('created_at')
      # byebug
      if _ft_for.count > 1
        _amto = 0
        _ft_for_id = _ft_for.last.id
        _ft_for.each do |trc|
          _amto = _amto + trc.amounttotal
         # byebug
          if trc.id != _ft_for_id
            trc.destroy
          else
            trc.amounttotal = _amto
            trc.netamount = _amto
            trc.save
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_future_transaction
     # byebug
      @future_transaction = FutureTransaction.find(params[:id])
      
    end
    def set_charts
      @chart_clones = ChartClone.all
      @partcharts = Chart.where("users_id = ? and glcode = ?" , current_user.id, ChartClone.last.id)       
    end     
    # Never trust parameters from the scary internet, only allow the white list through.
    def future_transaction_params
      params.require(:future_transaction).permit(:amounttotal, :date, :co, :chart_clones_id, :code, :users_id, :gsttype, :netamount, :gstamount, :gst_include, :for_moving) 
    end
end
