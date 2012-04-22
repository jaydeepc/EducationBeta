class AnswersController < ApplicationController
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create

  end

  def show
    @answer = Answer.find(params[:id])
  end
end
