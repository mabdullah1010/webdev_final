class StaticPagesController < ApplicationController
  def home
    if logged_in?
    @recent_documents = current_user.documents.order(created_at: :desc).limit(3)
    end
  end

  def about
  end

  def help
  end

  def all_users
  end

  def other_users
  end

  def view_files
  end

  def signup
  end

  def login
  end
end
