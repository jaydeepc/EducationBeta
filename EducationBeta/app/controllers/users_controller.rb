class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    params[:user][:is_tutor] = true ? (params[:type] == "Tutor") : false
    @user = User.new(params[:user])
    p params[:user].inspect
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
end
