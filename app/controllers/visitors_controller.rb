class VisitorsController < ApplicationController
  def index
    $lang = 0
    init_0
  end
  def index_rus
    $lang = 1
    init_0
  end
  def main_menu
    # byebug
    @datesetting = Datesetting.where(users_id: current_user.id).first
    # byebug
    if current_user.expire_date < DateTime.now
      current_user.category = 0
    else
      if current_user.category == 0
        current_user.category = 2
      end
    end
    
    @user = User.where("id = ?",current_user.id).first
    @user.update_columns("category" => current_user.category)
    # byebug
    # @user.save(current_user)
  end

  def contacts
    
  end

  def adminservice
    
  end

  # def inits
  #  @transfering = Transfering.new
  # end
end

private

  def init_0
    # Initiate filling of charts
    if !Chart.all.any?
      filen = File.read(Rails.root.join('app/assets/charts.csv'))
      ssk = Array.new
      rr = filen.split(/\r?\n/)
      i = 0
      while !rr[i].nil?
        ssk[i] = rr[i].split(',')
        i+=1
      end
      rrc = rr.count-1

      for i in 0..rrc
        @chart = Chart.new
        ssc = ssk[i].count-1
        for j in 0..ssc
          @chart.gst = ssk[i][1]
          @chart.code = ssk[i][2]
          @chart.content = ssk[i][3]
          @chart.header = ssk[i][4]
          @chart.created_at = ssk[i][5]
          @chart.updated_at = ssk[i][6]
          @chart.users_id = 0
          @chart.glcode = @chart.code.to_i/10000
        end
        @chart.save
      end # for
     end  # if 

     if !ChartClone.all.any?
        @chartclone = ChartClone.new
        @chartclone.cc_id = 1
        @chartclone.content = "Assets"
        @chartclone.created_at = DateTime.now
        @chartclone.updated_at = DateTime.now
        @chartclone.save
        @chartclone = ChartClone.new
        @chartclone.cc_id = 2
        @chartclone.content = "Liabilities"
        @chartclone.created_at = DateTime.now
        @chartclone.updated_at = DateTime.now
        @chartclone.save
        @chartclone = ChartClone.new
        @chartclone.cc_id = 3
        @chartclone.content = "Equaty"
        @chartclone.created_at = DateTime.now
        @chartclone.updated_at = DateTime.now
        @chartclone.save
        @chartclone = ChartClone.new
        @chartclone.cc_id = 4
        @chartclone.content = "Income"
        @chartclone.created_at = DateTime.now
        @chartclone.updated_at = DateTime.now
        @chartclone.save
        @chartclone = ChartClone.new
        @chartclone.cc_id = 5
        @chartclone.content = "Cost of sales"
        @chartclone.created_at = DateTime.now
        @chartclone.updated_at = DateTime.now
        @chartclone.save
        @chartclone = ChartClone.new
        @chartclone.cc_id = 6
        @chartclone.content = "Expenses"
        @chartclone.created_at = DateTime.now
        @chartclone.updated_at = DateTime.now
        @chartclone.save

     end  # if 

     if !AdminTable.all.any?
        @admintable = AdminTable.new
        @admintable.name = "users"
        @admintable.lastmodified = DateTime.now
        @admintable.created_at = DateTime.now
        @admintable.updated_at = DateTime.now
        @admintable.save
        @admintable = AdminTable.new
        @admintable.name = "charts"
        @admintable.lastmodified = DateTime.now
        @admintable.created_at = DateTime.now
        @admintable.updated_at = DateTime.now
        @admintable.save
        @admintable = AdminTable.new
        @admintable.name = "transactions"
        @admintable.lastmodified = DateTime.now
        @admintable.created_at = DateTime.now
        @admintable.updated_at = DateTime.now
        @admintable.save
        @admintable = AdminTable.new
        @admintable.name = "temp_transactions"
        @admintable.lastmodified = DateTime.now
        @admintable.created_at = DateTime.now
        @admintable.updated_at = DateTime.now
        @admintable.save
        @admintable = AdminTable.new
        @admintable.name = "future_transactions"
        @admintable.lastmodified = DateTime.now
        @admintable.created_at = DateTime.now
        @admintable.updated_at = DateTime.now
        @admintable.save
        @admintable = AdminTable.new
        @admintable.name = "employees"
        @admintable.lastmodified = DateTime.now
        @admintable.created_at = DateTime.now
        @admintable.updated_at = DateTime.now
        @admintable.save
     end  # if
    end