class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user or @user.category == 2
      redirect_to :back, :alert => "Access denied."
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
