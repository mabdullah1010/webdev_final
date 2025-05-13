class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_path, notice: "Welcome back!"

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
    end

  
    def destroy
      log_out if logged_in?
      redirect_to root_path, notice: "Successfully logged out."
    end

    def current_user_id
      @user = User.find_by(email: params[:session][:email].downcase)
      current_user_id = @user.id
    end


	
  
  
  end
  