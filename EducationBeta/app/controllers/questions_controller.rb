class QuestionsController < ApplicationController

  before_filter :require_user

  def new
    @question = Question.new
    @user = current_user
  end

  def create
    question_params = Hash.new
    question_params[:student_id] = params[:user_id] 
    question_params[:tutor_id] = Tutor.find(:first, :conditions => {:email => params[:tutor]}).id
    question_params[:subject_id] = Subject.find(:first, :conditions => {:subject => params[:subject]}).id
    question_params[:status] = "new"
    question_params[:description] = params[:question][:description]
    question_params[:title] = params[:question][:title]
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
    @questions = current_user.questions
  end

  def update
   @question = Question.find(params[:id]) 
   question_params = Hash.new
   question_params[:tutor_id] = Tutor.find_by_email(params[:tutor]).id
   question_params[:subject_id] = Subject.find_by_subject(params[:subject]).id
   question_params[:description] = params[:question][:description]
   question_params[:title] = params[:question][:title]
   if @question.update_attributes(question_params)
     redirect_to user_questions_path
   else
     render "new"
   end  
  end
end
