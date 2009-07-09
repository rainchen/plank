class ActivationsController < ApplicationController
  # user should enter email and then send activation email
  def new
    if request.post?
      @user = User.find_by_email(params[:email]) unless params[:email].empty?
      if @user
        if @user.active?
          flash[:notice] = "Your account has already activated."
        else
          flash[:notice] = "The activation link has been sent to your email,please checkout your email box."
          @user.deliver_activation_instructions!
        end
      else
        flash[:notice] = "No user was found with that email address"
      end
    end
    @user = User.new({:email => params[:email]}) if @user.nil?
  end
  
  def create
    @user = User.find_using_perishable_token(params[:activation_code], 1.week)
    unless @user
      flash[:notice] = "The activation url has expired."
    else
      if @user.active?
        flash[:notice] = "Your account has already activated."
      else
        if @user.activate!
          flash[:notice] = "Your account has been activated."
          # TODO: send mails in the background
          @user.deliver_activation_confirmation!
        end
      end
    end
    redirect_to root_url
  end
end
