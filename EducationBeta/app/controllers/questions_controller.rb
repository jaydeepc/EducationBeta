class QuestionsController < ApplicationController

  before_filter :require_user

  def new
    @question = Question.new
    @user = current_user
  end

  def create
    question_params = Hash.new
    question_params[:student_id] = params[:id] 
    question_params[:tutor_id] = User.find(:first, :conditions => {:email => params[:tutor]}).id
    question_params[:subject_id] = Subject.find(:first, :conditions => {:subject => params[:subject]}).id
    question_params[:status] = "new"
    question_params[:description] = params[:question][:description]
    @question = Question.new question_params
    if @question.save
      redirect_to user_questions_path
    else
      render "new"
    end  
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Tutor.find(current_user.id).questions if current_user.is_tutor?
    @questions = Student.find(current_user.id).questions unless current_user.is_tutor?
  end
end
