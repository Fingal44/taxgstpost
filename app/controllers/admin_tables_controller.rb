class AdminTablesController < ApplicationController
  before_action :set_admin_table, only: [ :show, :edit, :update, :destroy]

  # GET /admin_tables
  # GET /admin_tables.json
  def index
    @admin_tables = AdminTable.all
  end

  # GET /admin_tables/1
  # GET /admin_tables/1.json
  def show
    # byebug
  end

  # GET /admin_tables/new
  def new
    @admin_table = AdminTable.new
  end

  # GET /admin_tables/1/edit
  def edit
  end

  # POST /admin_tables
  # POST /admin_tables.json
  def create
    @admin_table = AdminTable.new(admin_table_params)

    respond_to do |format|
      if @admin_table.save
        format.html { redirect_to @admin_table, notice: 'Admin table was successfully created.' }
        format.json { render :show, status: :created, location: @admin_table }
      else
        format.html { render :new }
        format.json { render json: @admin_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_tables/1
  # PATCH/PUT /admin_tables/1.json
  def update
    respond_to do |format|
      if @admin_table.update(admin_table_params)
        format.html { redirect_to @admin_table, notice: 'Admin table was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_table }
      else
        format.html { render :edit }
        format.json { render json: @admin_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_tables/1
  # DELETE /admin_tables/1.json
  def destroy
    @admin_table.destroy
    respond_to do |format|
      format.html { redirect_to admin_tables_url, notice: 'Admin table was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_table
      @admin_table = AdminTable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_table_params
      params.require(:admin_table).permit(:name, :lastmodified)
    end
end
