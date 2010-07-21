class UserSessionsController < ApplicationController
  skip_before_filter :authorize

  def new
    redirect_to new_user_path if User.count == 0
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      respond_to do |format|
        format.html do
          expire_action :controller => 'people', :action => ['index', 'show']
          flash[:notice] = "Successfully logged in."
          redirect_to root_url
        end
        format.js { render :action => 'redirect' }
      end
    else
      respond_to do |format|
        format.html { render :action => 'new' }
        format.js
      end

    end
  end

  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy
    expire_action :controller => 'people', :action => ['index', 'show']
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
