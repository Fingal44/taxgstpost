class VisitorsController < ApplicationController
  def index
    $lang = 0
  end
  def index_rus
    $lang = 1
  end
  def main_menu
    # byebug
    @datesetting = Datesetting.where(users_id: current_user.id)
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
end
