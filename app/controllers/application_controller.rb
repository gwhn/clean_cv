# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_filter :authorize
  before_filter :set_current_user

  protected
  def authorize
    unless current_user
      redirect_to login_path
    end
  end

  def permission_denied
    flash[:error] = "Permission denied!"
    redirect_to root_url
  end

  private
  def set_current_user
    Authorization.current_user = current_user
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end
