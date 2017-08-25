class SessionsController < ApplicationController
  before_action :require_current_user!, except: [:destroy]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(log_in_params[:user_name],
                                     log_in_params[:password])

    if @user.nil?
      flash.now[:errors] = ["Invalid credentials"]
    else
      log_in!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    current_user.reset_session_token! unless current_user.nil?
    session[:session_token] = nil
    redirect_to cats_url
  end

  private

  def log_in_params
    params.require(:user).permit(:user_name, :password)
  end
end
