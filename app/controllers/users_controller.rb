class UsersController < ApplicationController
  before_action :require_current_user!
  
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      flash.now[:errors] = ["Failed to save"]
    end
  end


  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
