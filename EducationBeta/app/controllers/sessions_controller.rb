class SessionsController < ApplicationController

  before_filter :require_user, :only => :destroy
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :is_registered, :only => [:create]

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      @user = user
      session[:user_id] = user.id
      redirect_to user_path({:id => user.id})
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  private
  def is_registered
    begin
      unless User.find_by_email(params[:email]).status == "registered"
        redirect_to root_url, :notice => "You are not successfully registered yet. Please follow the validation email to successfully register"
      end
    rescue
      redirect_to("/500.html")
    end
  end
end
