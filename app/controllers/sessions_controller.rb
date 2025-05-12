class SessionsController < ApplicationController
    def new
    end
  
    def create
      @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])
        # Log the user in and redirect to the user's show page.
        reset_session
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        remember(@user)
        log_in(@user)
        redirect_to @user
      else
        # Create an error message.
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new', status: :unprocessable_entity
      end
    end
  
    def destroy
      log_out if logged_in?
      redirect_to root_url, status: :see_other
    end

    def current_user_id
      @user = User.find_by(email: params[:session][:email].downcase)
      current_user_id = @user.id
    end
  
  
  end
  