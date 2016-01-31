class TransferingsController  < ApplicationController
  # require 'csv'
  # require 'open-uri'

  def new
    @transfering = Transfering.new
  end

  def create
    # byebug
    bankn = transfering_params[:argb]
    file_data = transfering_params[:args]
    if file_data.respond_to?(:read)
      filen = file_data.read
    elsif file_data.respond_to?(:path)
      filen = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end
 
   # filen = file_contents
    
    ssk = Array.new
    rr = filen.split(/\r?\n/)
    i = 0
    while !rr[i].nil?
        ssk[i] = rr[i].split(',')
        i+=1
    end
    rrc = rr.count-1
    
    case bankn
     
    when  "1"
      for i in 0..rrc
        @temp_transaction = TempTransaction.new
        ssc = ssk[i].count-1
        for j in 0..ssc
          @temp_transaction.amounttotal =  ssk[i][5]
          @temp_transaction.what=  ssk[i][0]
          @temp_transaction.who=  ssk[i][1]
          @temp_transaction.date=  ssk[i][6]
          @temp_transaction.gst_include =  1
          @temp_transaction.co = transfering_params[:argn]
          @temp_transaction.users_id = current_user.id
        end
        @temp_transaction.save
      end

    when  "2" #ANZ visa
      for i in 0..rrc
        @temp_transaction = TempTransaction.new
        ssc = ssk[i].count-1
        for j in 0..ssc
          @temp_transaction.amounttotal =  ssk[i][2]
          @temp_transaction.what=  ssk[i][0]
          @temp_transaction.who=  ssk[i][3]
          @temp_transaction.date=  ssk[i][4]
          @temp_transaction.gst_include =  1
          @temp_transaction.co = transfering_params[:argn]
          @temp_transaction.users_id = current_user.id
        end
        @temp_transaction.save
      end      
 
    when  "3" #ASB
      for i in 0..rrc
        @temp_transaction = TempTransaction.new
        ssc = ssk[i].count-1
        for j in 0..ssc
          @temp_transaction.amounttotal =  ssk[i][6]
          @temp_transaction.what=  ssk[i][2]
          @temp_transaction.who=  ssk[i][4]
          @temp_transaction.date=  ssk[i][0]
          @temp_transaction.gst_include =  1
          @temp_transaction.co = transfering_params[:argn]
          @temp_transaction.users_id = current_user.id
        end
        @temp_transaction.save
      end      
 
    when "4" # BNZ
      for i in 0..rrc
        @temp_transaction = TempTransaction.new
        ssc = ssk[i].count-1
        for j in 0..ssc
          @temp_transaction.amounttotal =  ssk[i][1]
          @temp_transaction.what=  ssk[i][2]
          @temp_transaction.who=  ssk[i][3]
          @temp_transaction.date=  ssk[i][0]
          @temp_transaction.gst_include =  1
          @temp_transaction.co = transfering_params[:argn]
          @temp_transaction.users_id = current_user.id
        end
        @temp_transaction.save
      end     

    end #case 
  end  #create

  private
    
    def set_transfering
      @transfering = Transfering.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def transfering_params
      params.require(:transfering).permit(:argb, :argn, :args)
    end
end
