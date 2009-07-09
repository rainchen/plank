class HomeController < ApplicationController
  layout 'application'

  def index
    if current_user
      render :template => 'home/main'
    else
      redirect_to new_user_session_url
    end
  end
  
end
