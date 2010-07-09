class UserSessionsController < ApplicationController
  skip_before_filter :authorize
  
  def new
    redirect_to new_user_path if User.count == 0
    @user_session = UserSession.new
    expire_action :controller => 'home', :action => 'index'
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
