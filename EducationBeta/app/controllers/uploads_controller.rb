class UploadsController < ApplicationController

  before_filter :require_user
  before_filter :is_allowed, :only => [:create, :update]
  helper_method :is_allowed

  def new
    @upload = Upload.new
  end

  def create
     @upload = Upload.new(params[:upload])
     if @upload.save!
       @upload.update_attributes({:user_id => current_user.id})
       redirect_to uploads_path
     else
       redirect_to("/500.html")
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
