class UserMailer < ActionMailer::Base
  default :from => "sumanth@educationbeta.com"
  
  def welcome_email(user)
    @user = user
    @url = "http://#{APP_CONFIG['domain']}:#{APP_CONFIG['port']}/validate/#{user.validation_uuid}"
    mail(:to => user.email, :subject => "Welcome to education beta") 
  end
end
