# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize
  
  helper :all # include all helpers, all the time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  protected
  def authorize
    unless current_user
      redirect_to login_path
    end
  end

  def find_person
    @person_id = params[:person_id]
    return (redirect_to(people_url)) unless @person_id
    @person = Person.find(@person_id)
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end
