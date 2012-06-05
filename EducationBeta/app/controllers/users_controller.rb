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
        create_tutor_subjects(params[:subject], @user) if @user.is_tutor?
        UserMailer.welcome_email(@user).deliver
        redirect_to root_url, :notice => "Successfully Signed up!"
      else
        render "new"
      end
    rescue Exception => e
      Rails.logger.error e.backtrace 
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

  def resend_validation
    begin
      user = User.find_by_email(params[:email])
      respond_to do |format|
        if user.status == 'pending'
          UserMailer.welcome_email(user).deliver
          format.html {redirect_to root_url, :notice => 'Validation email successfully sent.'}
          format.js
        else
          format.html {redirect_to root_url, :notice => 'User is not in right state to validate.'}
        end
      end
    rescue
      redirect_to("/500.html")
    end
  end

  private

  def create_tutor_subjects(subjects, user)
    subject_ids = subjects.keys.select {|key| subjects[key] == "1"}
    subject_ids.each do |subject_id|
      user_subject = TutorSubject.create(:tutor_id => user.id, :subject_id => subject_id)
    end
  end
end
