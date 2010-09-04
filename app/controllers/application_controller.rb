# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :require_user
  before_filter :set_current_user

  layout :choose_layout

  protected
  def require_user
    unless current_user
      redirect_to login_path
    end
  end

  def permission_denied
    flash[:error] = 'Permission denied!'
    respond_to do |format|
      format.html { redirect_to(:back) rescue redirect_to root_url }
      format.xml { head :unauthorized }
      format.js { head :unauthorized }
    end
  end

  private
  def choose_layout
    request.xhr? ? nil : 'standard'
  end

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

  def load_person
    @person = Person.find params[:person_id]
  end

  def load_person_company
    load_person
    @company = @person.companies.find params[:company_id]
  end

  def load_person_company_project
    load_person_company
    @project = @company.projects.find params[:project_id]
  end
end
