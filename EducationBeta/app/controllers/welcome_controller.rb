class WelcomeController < ApplicationController

  def show
    redirect_to user_path({:id => current_user.id}) if current_user
  end
end
