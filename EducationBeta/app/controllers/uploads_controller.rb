class UploadsController < ApplicationController

  before_filter :require_user
  before_filter :is_allowed, :only => [:create, :update]
  helper_method :is_allowed

  def new
    @upload = Upload.new
  end


  private
  def is_allowed
    unless current_user.type == 'Tutor'
      redirect_to("/403.html")
      return false
    end
  end
end
