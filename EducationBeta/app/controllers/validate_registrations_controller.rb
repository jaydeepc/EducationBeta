class ValidateRegistrationsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.status == 'pending'
      user.send_validation_token
      redirect_to root_url, :notice => "Email has been sent with instructions to confirm registration."
    else
      redirect_to root_url, :notice => "This user does not need any confirmation as he/she is already confirmed or does not exist in our system!"
    end
  end

  def edit
    @user = User.find_by_validation_token!(params[:id])
  end

  def update
    @user = User.find_by_validation_token!(params[:id])
    if @user.validation_token_sent_at < 2.hours.ago
      redirect_to new_validate_registration_path, :alert => "Validation token has expired."
    else
      @user.update_attributes(:status => "registered")
      redirect_to root_url, :notice => "User is successfully registered!"
    end
  end
end
