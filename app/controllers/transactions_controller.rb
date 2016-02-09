require Rails.root.join('lib/tools', 'make_calcs.rb')

class TransactionsController < ApplicationController
 before_filter :authenticate_user!
 before_filter :set_transaction, only: [:show, :edit, :update, :destroy]
 before_filter :prepare_gst_return, only: [:gst_return, :tax_return]
 before_filter :prepare_tax_return, only: [:tax_return]

 def index1
   @gstended = Now()
   @gstperiod = 6
   
 end
  # GET /transactions
  # GET /transactions.json
  def index
    @sd = Datesetting.where("users_id = ?", current_user.id)
    @ed = Datesetting.where("users_id = ?", current_user.id)
    # byebug
    @transactions = Transaction.where("users_id = ? and date >= ? and date <= ?", current_user, @sd.first.startdate, @ed.first.enddate)
    @chart_clones = ChartClone.all
    @partcharts = Chart.where("users_id = ? and glcode = ?  and header = ?" , current_user.id, ChartClone.last.id,0)

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @transactions }
    end
  end
  def indexfull
    @sd = Datesetting.where("users_id = ?", current_user.id)
    @ed = Datesetting.where("users_id = ?", current_user.id)
    # byebug
    @transactions = Transaction.where("date >= ? and date <= ?", @sd.first.startdate, @ed.first.enddate)
    @chart_clones = ChartClone.all
    @partcharts = Chart.where("glcode = ?  and header = ?" , ChartClone.last.id,0)

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @transactions }
    end
  end
  # GET /transactions/1
  # GET /transactions/1.json
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.json
  def new
    @transaction = Transaction.new
    @transactions = Transaction.all

   # @glchart = Chart.where("code % 10000 == 0")
     @chart_clones = ChartClone.all
     @partcharts = Chart.where("users_id = ? and glcode = ?  and header = ?" , current_user.id, ChartClone.last.id,0)
     @megatrans = @transaction

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
    @chart_clones = ChartClone.all
    glc = ChartClone.where("id = ?", @transaction.chart_clones_id).last.id
    @partcharts = Chart.where("users_id = ? and glcode = ?" , current_user.id, glc)
    @megatrans = @transaction
    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @transaction }
    end
  end
    
  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    
    make_calcs(@transaction,transaction_params)
    # create_extra_trans
    respond_to do |format|
      if @transaction.update(transaction_params)
       # create_extra_trans
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render json: @transaction, status: :created, location: @transaction }

      else
        format.html { render action: "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /transactions/1
  # PUT /transactions/1.json
  def update
   # @transaction = Transaction.find(params[:id])
   @transaction.update(transaction_params)
   
    make_calcs(@transaction,transaction_params)
  
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render json: @transaction, status: :updated, location: @transaction }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

 def update_codes
 
    @partcharts = Chart.where("users_id = ? and glcode = ?  and header = ?" , current_user.id, params[:chart_clones_id],0)
    respond_to do |format|
      format.js
    end
 end
 
 def update_codes_edit
  
    @partcharts = Chart.where("users_id = ? and glcode = ?  and header = ?" , current_user.id, params[:chart_clones_id],0)
 
    respond_to do |format|
     format.js
   end
 end

 def gst_return
   @gst_4_0 = 0
   @gst_6_0 = 0
   @transactions_0.each() do  |row|
     if row.gsttype == 1
       if row.chart_clones_id == 4
         @gst_4_0+=row.amounttotal
       end
       if row.chart_clones_id == 6
         @gst_6_0+=row.amounttotal
       end
     end
   end
   
   @gst_4_1 = 0
   @gst_6_1 = 0
   @transactions_1.each() do  |row|
     if row.gsttype == 1
       if row.chart_clones_id == 4
         @gst_4_1+=row.amounttotal
       end
       if row.chart_clones_id == 6
         @gst_6_1+=row.amounttotal
       end
     end
   end
   
   @gst_4_2 = 0
   @gst_6_2 = 0
   @transactions_2.each() do  |row|
     if row.gsttype == 1
       if row.chart_clones_id == 4
         @gst_4_2+=row.amounttotal
       end
       if row.chart_clones_id == 6
         @gst_6_2+=row.amounttotal
       end
     end
   end  
   
   @gstgst_4_0 = (@gst_4_0 * 3/23).round(2)
   @gstgst_6_0 = (@gst_6_0 * 3/23).round(2)
   @gstgst_4_1 = (@gst_4_1 * 3/23).round(2)
   @gstgst_6_1 = (@gst_6_1 * 3/23).round(2)
   @gstgst_4_2 = (@gst_4_2 * 3/23).round(2)
   @gstgst_6_2 = (@gst_6_2 * 3/23).round(2)
   @gst_rez_2 = @gstgst_4_2 - @gstgst_6_2
   @gst_rez_1 = @gstgst_4_1 - @gstgst_6_1
 end
 
 def tax_return
   @sd = Datesetting.where("users_id = ?", current_user.id)
   @ed = Datesetting.where("users_id = ?", current_user.id)
   @ftran_2 = FutureTransaction.where("users_id = ? AND co in (?) and date >= ? and date <= ?",current_user,2,@sd.first.startdate, @ed.first.enddate)
   @ftran_1 = FutureTransaction.where("users_id = ? AND co in (?) and date >= ? and date <= ?",current_user,1,@sd.first.startdate, @ed.first.enddate)
   @ftran_2_exp = @ftran_2.sum(:netamount)
   @ftran_1_exp = @ftran_1.sum(:netamount)
# byebug
   @chartwi = Chart.where("users_id = ? and glcode = ?", current_user.id, 4).order("code")
   @chartwe = Chart.where("users_id = ? and glcode = ?", current_user.id, 6).order("code")
   # @charta = Chart.where("users_id = ? and header == ?", current_user.id,0)

   @charta = @chartwi.where("header = ?", 0)
   @amount_2itotal = 0
   @amount_1itotal = 0

   @charta.each() do |row|
     rcode = row.code

     @tran_2 = @transactions_2.where("code = ?",rcode)
     amount_2i = 0
     @tran_2.each() do |tr|
       amount_2i += tr.netamount
     end
     @amount_2itotal += amount_2i
     row.amount_2 = amount_2i
     # updated last record
     row.update(:amount_2 => amount_2i)
    
     @tran_1 = @transactions_1.where("code = ?",rcode)
     amount_1i = 0
     @tran_1.each() do |tr|
       amount_1i += tr.netamount
     end
     @amount_1itotal += amount_1i
     row.amount_1 = amount_1i
     # updated last record
     row.update(:amount_1 => amount_1i)
   end  
   @chartb = @chartwe.where("header = ?", 0)
   # @amount_2itotal_ = 0
   @amount_2etotal = 0
   @amount_1etotal = 0
  
   @chartb.each() do |row|
     rcode = row.code
     @tran_2 = @transactions_2.where("code = ?",rcode)
     amount_2e = 0
     
     @tran_2.each() do |tr|
       amount_2e += tr.netamount
     end
     @amount_2etotal += amount_2e
     # byebug


     row.amount_2 = amount_2e
     # updated last record
     row.update(:amount_2 => amount_2e)
     # byebug
     @tran_1 = @transactions_1.where("code = ?",rcode)
     amount_1e = 0
     
     @tran_1.each() do |tr|
       amount_1e += tr.netamount
     end
     @amount_1etotal += amount_1e
 
     row.amount_1 = amount_1e
     # updated last record
     row.update(:amount_1 => amount_1e)

   end 
   if @ftran_2_exp != nil
       @amount_2etotal +=  @ftran_2_exp
   end
   if @ftran_1_exp != nil
       @amount_1etotal +=  @ftran_1_exp
   end
   # if @ftran_2_exp != nil
   #  @co_inc = @amount_2itotal - @amount_2etotal - @ftran_2_exp
   # else
     @co_inc = @amount_2itotal - @amount_2etotal
   # end 
   @co_inc_tax = calc_co_tax(@co_inc)
   # if @ftran_1_exp != nil
   # @pe_inc = @amount_1itotal - @amount_1etotal -  @ftran_1_exp
   # else
     @pe_inc = @amount_1itotal - @amount_1etotal
   #end
   @pe_inc_tax = calc_person_tax(@pe_inc)
   @unallocated_expenses = 0
   @transactions_0.each() do |tr|
      @unallocated_expenses += tr.netamount
   end
   @coextra,@peextra = recoms(@co_inc,@pe_inc,@unallocated_expenses)
 end
 
 def reallocate
 
 end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      
      @transaction = Transaction.find(params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:amounttotal, :date, :netamount, :gstamount, :gsttype, :users_id, :chart_clones_id, :code, :gst_include, :co, :who, :what, :extra_all, :extra_tax, :extra_acc, :extra_sl, :extra_ks)
    end

   def set_errors
    @errors = ActiveModel::Errors.new(self)
   end
   
   
   
   def prepare_gst_return
     @sd = Datesetting.where("users_id = ?", current_user.id)
     @ed = Datesetting.where("users_id = ?", current_user.id)
     @transactions_0 = Transaction.where("users_id = ? AND co in (?) and date >= ? and date <= ? and chart_clones_id = ?",current_user,0,@sd.first.startdate, @ed.first.enddate,6)
     @transactions_1 = Transaction.where("users_id = ? AND co in (?) and date >= ? and date <= ?",current_user,1,@sd.first.startdate, @ed.first.enddate)
     @transactions_2 = Transaction.where("users_id = ? AND co in (?) and date >= ? and date <= ?",current_user,2,@sd.first.startdate, @ed.first.enddate)
     # byebug
   end
   
   def prepare_tax_return
     @sd = Datesetting.where("users_id = ?", current_user.id)
     @ed = Datesetting.where("users_id = ?", current_user.id)
     # Model.where(:foo => 'bar').where(:attr => 1).update_all("author = 'David'")
     Chart.where(:users_id => current_user.id).update_all("amount_2 = 0")
     Chart.where(:users_id => current_user.id).update_all("amount_1 = 0")
 
     @charth = Chart.where("header = ?", 1)
     @chartr = Chart.where("header = ?", 0)
   # byebug
     @charth.each() do |ch2h|
       tempam = 0
       @tran_2_r_temp = @transactions_2.where("code > ? and code <= ?", ch2h.code, ch2h.code + 400)
       @tran_2_r_temp.each() do |tr2r|
         tempam += tr2r.netamount
       end
       ch2h.amount_2 = tempam 
       # ch2h.save
       # byebug
       tempam = 0
       @tran_1_r_temp = @transactions_1.where("code > ? and code <= ?", ch2h.code, ch2h.code + 400)
       @tran_1_r_temp.each() do |tr1r|
         tempam += tr1r.netamount
       end
       ch2h.amount_1 = tempam 
       ch2h.save
     end

   end 

   def calc_co_tax (amount)
     return amount*0.28.round(2)
   end

   def calc_person_tax (amount)
     taxamount = 0
     case amount
       when -1000000 .. 0
         taxamount = 0
       when 0 .. 14000
         taxamount = amount * 0.105
       when 14000 .. 24000
         taxamount = 1470 + (amount - 14000) * 0.175
       when 24000 .. 44000
         taxamount = 950 + (amount - 14000) * 0.175
       when 44000 .. 48000
         taxamount = 1470 + (amount - 14000) * 0.175
       when 48000 .. 70000
         taxamount = 7420 + (amount - 48000) * 0.3
       else
         taxamount = 14020 + (amount - 70000) * 0.33
      end


     return taxamount.round(2)
    end

    def recoms(_co,_pe,_unal)
      retco = 0
      retpe = 0
      if _unal == 0
        retco = 0
        retpe = 0
      else
        case _pe
          when -1000000 .. 0
            if _pe*(-1) >= _unal
              retco = 0
              retpe = _unal
            else
              retco = 0
              retpe = _unal
            end  
          when 0 .. 44000
            _retpe = 44000 - _pe
            if _retpe >= _unal
              retco = 0
              retpe = _unal
            else
              retco = _unal - _retpe # ?
              retpe = _retpe
            end 
          when 44000 .. 48000
            _retpe = 48000 - _pe
            if _retpe >= _unal
              retco = 0
              retpe = _unal
            else
              retco = _unal - _retpe # ?
              retpe = _retpe
            end 
          else
            retco = _unal
            retpe = 0
        end

      end
      return retco, retpe
    end

end

