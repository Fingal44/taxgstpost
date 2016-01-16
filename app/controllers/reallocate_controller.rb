class ReallocateController  < ApplicationController
  def new
    @tran_for_reallocate = Transaction.where("users_id = ? and co = ?",current_user.id,0)
  end

  def create
  	Transaction.where("users_id = ? and co = ?",current_user.id,0).update_all(co: params[:argent])
  end
end