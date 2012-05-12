class AnswersController < ApplicationController

  before_filter :require_user
  before_filter :is_allowed, :only => [:create, :update]
  helper_method :is_allowed

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    answer_params={}
    answer_params[:description] = params[:answer][:description]
    answer_params[:question_id] = params[:question_id]
    @answer = Answer.new(answer_params)
    if @answer.save
      question = Question.find(params[:question_id])
      question.update_attributes({:status => 'answered'})
      redirect_to user_question_path({:user_id => current_user.id, :id => params[:question_id]})
    else
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    if current_user.is_tutor?
      render "answers/tutors/show"
    else
      render "answers/students/show"
    end
  end

  def update
    answer_params={}
    answer_params[:description] = params[:answer][:description]
    answer_params[:question_id] = params[:question_id]
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(answer_params)
      question = Question.find(params[:question_id])
      question.update_attributes({:status => 'answered'})
      redirect_to user_question_path({:user_id => current_user.id, :id => params[:question_id]})
    else
      render 'show'
    end
  end

  private
  def is_allowed
    unless current_user.type == 'Tutor'
      redirect_to("/403.html")
      return false
    end
  end
end
