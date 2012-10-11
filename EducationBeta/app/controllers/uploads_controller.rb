class UploadsController < ApplicationController

  require 'fileutils'
  before_filter :require_user
  before_filter :is_allowed, :only => [:create, :update]
  helper_method :is_allowed

  def new
    @upload = Upload.new
  end

  def create
    params[:upload][:user_id] = current_user.id
    params[:upload][:subject_id] = Subject.find_by_subject(params[:subject]).id
    params[:upload][:standard_id] = Standard.find_by_name(params[:standard]).id
    params[:upload][:chapter_id] = Chapter.find_by_name(params[:chapter]).id
    Rails.logger.info params[:upload].inspect
    @upload = Upload.new(params[:upload])
    begin
      if @upload.save
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
  
  def destroy
    begin
      upload = Upload.find(params[:id])
      FileUitls.rm_rf upload.document.path
      upload.destroy
      render 'index'
    rescue Exception => e
      Rails.logger.info "#{e.message} \n #{e.backtrace}"
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
