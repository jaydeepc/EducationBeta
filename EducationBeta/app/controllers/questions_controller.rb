class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def show
  end
end
