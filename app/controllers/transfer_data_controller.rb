class TransferDataController  < ApplicationController
  require 'csv'
  
  def new
  
  end

  def create
    bankn = params[:argb]
    filen0 = params[:args].from(-4)
    if filen0 == ".csv"
      filen = params[:args]
    else
      filen = params[:args] + ".csv"
    end
    # byebug
    if params[:argf].nil?
      ff = Dir.pwd
    else
      ff = params[:argf]
    end
    filen = ff + "/" + filen
   # byebug
    # system "transfer data", params[:args]
    system "transfer data", filen
    case bankn
     
    when  "1"
      # byebug
      CSV.foreach(filen) do |row|
       # byebug
        rr = row.inspect
        ssk = rr.split(',')
        # byebug
        @temp_transaction = TempTransaction.new
        _amt = ssk[5].from(2).to(-2).to_f
        if _amt.to_f == 0.0
          _amt = ssk[5].from(6).to(-2).to_f
        end
        @temp_transaction.amounttotal =  _amt
        @temp_transaction.what=  ssk[0].from(2).to(-2)
        @temp_transaction.who=  ssk[1].from(2).to(-2)
        @temp_transaction.date=  ssk[6]
        @temp_transaction.gst_include=  1
        @temp_transaction.co = params[:argn]
        @temp_transaction.users_id = current_user.id
        # byebug
        @temp_transaction.save
      end

    when  "2" #ANZ visa
      
      CSV.foreach(filen) do |row|
        rr = row.inspect
        ssk = rr.split(',')
        # byebug
        @temp_transaction = TempTransaction.new
        _amt = ssk[2].from(2).to(-2).to_f
        if _amt.to_f == 0.0
          _amt = ssk[2].from(6).to(-2).to_f
        end
        @temp_transaction.amounttotal =  _amt
        @temp_transaction.what=  ssk[0].from(2).to(-2)
        @temp_transaction.who=  ssk[3].from(2).to(-2)
        @temp_transaction.date=  ssk[4]
        @temp_transaction.gst_include=  1
        @temp_transaction.co = params[:argn]
        @temp_transaction.users_id = current_user.id
        @temp_transaction.save
      end

    when  "3" #ASB
      num = 0 
      CSV.foreach(filen) do |row|
        num +=1
        if (num < 9)
           next
        end 
        rr = row.inspect
        ssk = rr.split(',')
        @temp_transaction = TempTransaction.new
        
        @temp_transaction.amounttotal =  ssk[6].from(2).to(-2).to_f
        @temp_transaction.what=  ssk[2]
        @temp_transaction.who=  ssk[4]
        @temp_transaction.date=  ssk[0]
        @temp_transaction.gst_include=  1
        @temp_transaction.co = params[:argn]
        @temp_transaction.users_id = current_user.id
        @temp_transaction.save
      end
    when "4" # BNZ
      CSV.foreach(filen) do |row|
        rr = row.inspect
        ssk = rr.split(',')
        # byebug
        @temp_transaction = TempTransaction.new
        @temp_transaction.amounttotal =  ssk[1].from(2).to(-2).to_f
        @temp_transaction.what=  ssk[2].from(2).to(-2)
        @temp_transaction.who=  ssk[3].from(2).to(-2)
        @temp_transaction.date=  ssk[0]
        @temp_transaction.gst_include=  1
        @temp_transaction.co = params[:argn]
        @temp_transaction.users_id = current_user.id
        @temp_transaction.save
      end    
    end #case 
  end  #create
end
