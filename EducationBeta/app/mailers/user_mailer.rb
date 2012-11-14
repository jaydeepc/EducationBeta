class UserMailer < ActionMailer::Base
  default :from => "sumanth@educationbeta.com"

  def validation_token(user)
    @user = user
    mail(:to => user.email, :subject => "Confirm your registration") 
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
