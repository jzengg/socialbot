class SessionsController < ApplicationController
  before_action :redirect_logged_in, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "Successfully logged in"
      redirect_to products_path
    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Signed out"
    redirect_to root_path
  end
end
