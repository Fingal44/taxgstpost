require Rails.root.join('lib/tools/create_future_trans.rb')
class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :make_payment, :create]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.where("users_id = ?",current_user.id)
  end
  def indexfull
    @employees = Employee.all
  end
  # GET /employees/1
  # GET /employees/1.json
  def show
    #hh = 'show'
    # byebug
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    if params[:brutto] != nil
      # hh = 'create'
      # byebug
      make_payment

    else
      @employee = Employee.new(employee_params)
      @employee.users_id = current_user.id
      @employee.fio = @employee.firstname.chars.first.upcase + "." + @employee.lastname
    # byebug
      respond_to do |format|
        if @employee.save
          around_create
          format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
          format.json { render :show, status: :created, location: @employee }
        else
          format.html { render :new }
          format.json { render json: @employee.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    tempfio = @employee.fio
    chartsalary = tempfio + " salary to pay"
    @employee.destroy
    @chart_to_del = Chart.where("content = ?",chartsalary)
    idstart = @chart_to_del.first.id
    idfinish = idstart + 5
    @charts_to_del = Chart.where("id >= ? and id <= ?",idstart,idfinish)
    @charts_to_del.each do |d|
      d.destroy
    end
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      if params[:id] != nil
        @employee = Employee.find(params[:id])
      end
    end

    def make_payment
      their_amount = params[:brutto]
      their_period = params[:timeperiod]
      create_future_trans(their_amount,their_period)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params[:employee]
      params.require(:employee).permit(:firstname, :lastname, :irdcode, :taxcode, :accprocent, :kiwisaver, :taxprocent)
    end
    
    def make_chart_record(last_code,nn,chartcontent)
      chartcontent = " " + chartcontent + " to pay"
      @chart = Chart.new
      @chart.users_id = current_user.id
      @chart.glcode = 6
      @chart.header = 0
      @chart.code = last_code + nn
      @chart.gst = 0
      @chart.amount_1 = 0
      @chart.amount_2 = 0
      # fio = @employee.firstname.chars.first.upcase + "." + @employee.lastname
      fio = @employee.fio
      @chart.content = fio + chartcontent
      @chart.save
    end

    def around_create
      @employee.users_id = current_user.id
      if @employee.kiwisaver == nil
        @employee.kiwisaver = 0
      end
      # Found current chart code
      @charts = Chart.where("users_id = ? and code < ?",current_user.id,70000).order("code")
      @chartsl1 = @charts.last.code
      @chartsl2 = @chartsl1.round(-1)
      if @chartsl2 >= @chartsl1
        @chartsl = @chartsl2
      else
        @chartsl = @chartsl2 + 10
      end

      make_chart_record(@chartsl,1,"salary")
      
      make_chart_record(@chartsl,2,"tax")

      make_chart_record(@chartsl,3,"acc")

      make_chart_record(@chartsl,4,"student loan")

      make_chart_record(@chartsl,5,"kiwisaver")
      make_chart_record(@chartsl,6,"Holiday payment")
    end
end 
