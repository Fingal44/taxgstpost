class ExpImpsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @users = User.all
  end
 
  def new
    # byebug
    @exp_imps = AdminTable.all
    @task = "Export","Import"
  end 
  
  
  def show
    
  end
  
  def create
     require 'csv'
     
     # @texps = Bank.all
      # byebug
    tablen = params[:argt]
    actionn = params[:argb]
    filen = params[:args]
   
    # file = "#{Rails.root}/" + filen
    #  byebug
    if actionn == "Export"
      case tablen
     
        when  "1"
          @data = User.order(:created_at)
          # file = "#{Rails.root}/users.csv"
          # file = "#{Rails.root}/" + filen
          CSV.open( filen, 'w' ) do |writer|
          #  CSV.open( file, 'w' ) do |writer|
            @data.each do |ur|
               next unless ur.present?
               writer << [ur.id, ur.email,ur.sign_in_count, ur.current_sign_in_at, ur.last_sign_in_at, ur.current_sign_in_ip, ur.last_sign_in_ip, ur.created_at, ur.updated_at, ur.name, ur.category, ur.expire_date]
            end
          end   
             
          respond_to do |format|
            format.html { redirect_to root_url }
            format.csv { send_data @data.to_csv }
          end
        when  "2"
          @data = Chart.order(:users_id, :code)
          file = "#{Rails.root}/charts.csv"
          CSV.open( filen, 'w' ) do |writer|
            @data.each do |ur|
               next unless ur.present?
               writer << [ur.glcode, ur.gst, ur.code, ur.content, ur.header, ur.users_id, ur.amount_1, ur.amount_2, ur.created_at, ur.updated_at]
            end
          end   
             
          respond_to do |format|
            format.html { redirect_to root_url }
            format.csv { send_data @data.to_csv }
          end      
        when  "3"
        
        when  "4"
        
        when  "5"
              
      end #case 
    else
      case tablen
        when "1"
          CSV.foreach(filen) do |row|
        rr = row.inspect
        ssk = rr.split(',')
         # byebug
        @user = User.new
        @user.email = ssk[1].from(2).to(-2)
=begin
        @temp_transaction.amounttotal =  ssk[5].from(2).to(-2).to_f
        @temp_transaction.what=  ssk[0].from(2).to(-2)
        @temp_transaction.who=  ssk[1].from(2).to(-2)
        @temp_transaction.date=  ssk[6]
        @temp_transaction.gst_include=  1
        @temp_transaction.co = params[:argn]
        @temp_transaction.users_id = current_user.id
        @temp_transaction.save
=end
        @user.save
      end
        when "2"
          # byebug

          CSV.foreach(filen) do |row|
          rr = row.inspect
          ssk = rr.split(',')
         # byebug
          @chart = Chart.new
          @chart.code = ssk[2].from(2).to(-2)
          @chart.content = ssk[3].from(2).to(-2)
          @chart.gst = ssk[1].from(2).to(-2)
          @chart.header = ssk[4].from(2).to(-2)
          @chart.users_id = ssk[5].from(2).to(-2)
          @chart.created_at = ssk[8].from(2).to(-2)
          @chart.updated_at = ssk[9].from(2).to(-2)
          @chart.glcode = @chart.code.to_i/10000
=begin
        @temp_transaction.amounttotal =  ssk[5].from(2).to(-2).to_f
        @temp_transaction.what=  ssk[0].from(2).to(-2)
        @temp_transaction.who=  ssk[1].from(2).to(-2)
        @temp_transaction.date=  ssk[6]
        @temp_transaction.gst_include=  1
        @temp_transaction.co = params[:argn]
        @temp_transaction.users_id = current_user.id
        @temp_transaction.save
=end
          if @chart.users_id == 0
            @chart.save
          end
        end
        when "3"
        when "4"
        when "5"
      end #case
    end #if  
  end
  
 
end 

