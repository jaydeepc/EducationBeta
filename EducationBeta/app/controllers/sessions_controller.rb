class SessionsController < ApplicationController

  before_filter :require_user, :only => :destroy
  before_filter :require_no_user, :only => [:new, :create]

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      @user = user
      session[:user_id] = user.id
      redirect_to "/tutors/#{user.id}" if @user.is_tutor?
      redirect_to "/students/#{user.id}" unless @user.is_tutor?
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
