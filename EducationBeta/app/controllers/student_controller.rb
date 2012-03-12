class StudentController < ApplicationController
  
  before_filter :require_user

  def show
  end
end
