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
      Rails.logger.error(e.message + "\n" + e.backtrace) 
      redirect_to("/500.html")
    end  
  end

  def show
    if current_user.is_tutor?
      @graph = Report.new.report_filter_questions_by_subject_for_an_user current_user
      @graph_2 = Report.new.report_filter_answered_questions_by_subject_for_an_user current_user
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
          format.html {render :text => '<script type="text/javascript"> var r=alert("Validation mail successfully sent!");window.close(); </script>'}
          format.js
        else
          format.html {render :text => '<script type="text/javascript"> var r=alert("The validation mail can not be resent as the user is already validated");window.close(); </script>'}
        end
      end
    rescue
      format.html {render :text => '<script type="text/javascript"> var r=alert("There is some problem while sending the mail!");window.close(); </script>'}
    end
  end

  def show_popup
    render "welcome/resend_email"
  end   

  private

  def create_tutor_subjects(subjects, user)
    subjects.each do |subject|
      begin
        user_subject = TutorSubject.new(:tutor_id => user.id, :subject_id => Subject.find_by_subject(subject).id)
        user_subject.save!
      rescue Exception => e
        Rails.logger.error(e.message + "\n" + e.backtrace)
        raise e
      end
    end
  end
end
