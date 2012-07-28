class UploadsController < ApplicationController

  before_filter :require_user
  before_filter :is_allowed, :only => [:create, :update]
  helper_method :is_allowed

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(params[:upload])
    begin
      if @upload.save
        @upload.update_attributes({:user_id => current_user.id})
        redirect_to user_uploads_path(current_user.id)
      else
        render 'new'
      end
    rescue Exception => e
      Rails.logger.info "#{e.message} \n #{e.backtrace}"
      redirect_to("/500.html")
    end
  end

  def index
    @uploads = current_user.uploads
  end

  def show
    @upload=Upload.find(params[:id])
    redirect_to "/401.html" unless @upload.belongs_to?(current_user)
  end


  private
  def is_allowed
    unless current_user.type == 'Tutor'
      redirect_to("/403.html")
      return false
    end
  end
end
