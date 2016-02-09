class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
   @users = User.all.order("id")
  end

  def show
    # @user = User.find(params[:id])
  end  
  
  def edit
    # @user = User.find(params[:id])
  end
  def update
    @user.update(user_params)
  end
 def destroy
    # byebug
    oldid = @user.id
    @user.destroy
    # Chart.delete_all.where("id = ?",oldid)
    # Delete records from other tables
    Chart.where("users_id = ?", oldid).destroy_all
    # Datesetting.delete_all.where("id = ?",oldid)
    Datesetting.where("users_id = ?", oldid).destroy_all
    if TempTransaction.where("users_id = ?", oldid).any?
      TempTransaction.where("users_id = ?", oldid).destroy_all
    end
    if FutureTransaction.where("users_id = ?", oldid).any?
      FutureTransaction.where("users_id = ?", oldid).destroy_all
    end
    if Transaction.where("users_id = ?", oldid).any?
      Transaction.where("users_id = ?", oldid).destroy_all
    end
    if Employee.where("users_id = ?", oldid).any?
      Employee.where("users_id = ?", oldid).destroy_all
    end
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user =User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :category, :expire_date)
    end
 

end
