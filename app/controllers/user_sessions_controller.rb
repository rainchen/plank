class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Signed in successfully"
      redirect_to root_url
    else
      flash[:notice] = "Bad email or password"
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy unless @user_session.nil?
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
