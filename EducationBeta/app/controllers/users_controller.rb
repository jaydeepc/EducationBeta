class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show]

  def new
    @user = User.new
  end

  def create
    params[:user][:status] = "pending"
    params[:user][:validation_uuid] = UUIDTools::UUID.timestamp_create().to_s.gsub!(/-/,'')
    @user = User.new(params[:user])

    begin
      if @user.save
        @user_subject =  TutorSubject.create(:tutor_id => @user.id, :subject_id => Subject.find_by_subject(params[:subject]).id) if @user.is_tutor?
        UserMailer.welcome_email(@user).deliver
        redirect_to root_url, :notice => "Successfully Signed up!"
      else
        render "new"
      end
    rescue
      redirect_to("/500.html")
    end  
  end

  def show
    if current_user.is_tutor?
      render "users/tutors/show" 
    else
      render "users/students/show"
    end
  end

  def confirm_registration
    begin
      user = User.find_by_validation_uuid(params[:uuid])
      if user.status == 'pending'
        user.update_attributes({:status => 'registered'})
        redirect_to root_url, :notice => "Successfully Registered"
      else 
        redirect_to root_url, :notice => "User is already registered"
      end
    rescue
      redirect_to("/500.html")
    end
  end
end
