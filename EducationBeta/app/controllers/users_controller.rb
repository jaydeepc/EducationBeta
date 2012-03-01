class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    p "!!!!!!!!!!!!!!!!!!!"
    p params[:type].inspect
    p "!!!!!!!!!!!!!!!!!!!"
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
