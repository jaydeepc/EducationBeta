class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show]
  
  
  def new
    @user = User.new
  end

  def create
    params[:user][:status] = "pending"
    @user = User.new(params[:user])

    begin
      if @user.save
        map_subjects(params[:subject], @user) if @user.is_tutor?
        user.send_validation_token
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
      @graph_3 = Report.new.report_line_graph current_user    
      @graph_4 = Report.new.dummy_report current_user  
      render "users/tutors/show" 
    else
      render "users/students/show"
    end
  end

  private

  def map_subjects(subjects, user)
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
