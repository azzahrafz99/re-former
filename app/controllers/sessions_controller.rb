class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to posts_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to sign_in_path
  end
end
