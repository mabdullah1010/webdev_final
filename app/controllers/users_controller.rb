class UsersController < ApplicationController
      #all actions will have the @user available without explicitly looking up each time
  before_action :set_user, only: %i[show edit update destroy]
  #user has to be logged in to edit, update or destroy except when creating a new user
  before_action :require_login,except: [:new, :create]
  #only the authorized user can edit, update and delete their own profile
  before_action :require_correct_user, only: [:edit,:update,:destroy]

  
  def index
    @users = User.all
  end

  def show
    @documents = @user.documents.includes(:comments, :keywords)
    @comments = @user.comments.includes(:document)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      reset_session
      log_in(@user)
      redirect_to root_path, notice: "Welcome to Paperclip^^"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile Updated"
    else
      render :edit,status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    reset_session
    redirect_to root_path, notice: "Account Deleted"
  end
  
  def documents
    @user = User.find(params[:id])
    @documents = @user.documents.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def require_correct_user
    unless current_user?(@user)
      flash[:danger] = "Unauthorized access"
      redirect_to root_url
    end
  end

  def require_login
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end


end
