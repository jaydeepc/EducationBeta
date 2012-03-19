class SessionsController < ApplicationController

  before_filter :require_user, :only => :destroy
  before_filter :require_no_user, :only => [:new, :create]

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      if User.is_tutor?(params[:email])
        redirect_to "/tutors/#{user.id}", :notice => "Logged in!"
      else
        redirect_to "/students/#{user.id}", :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
