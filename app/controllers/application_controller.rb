# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :authenticate_user!
  before_filter :authorize_current_user

  layout :choose_layout

  after_filter :discard_flash_if_xhr

#  after_filter :flash_to_headers

  protected
  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

#  def flash_to_headers
#    return unless request.xhr?
#    response.headers['X-Message'] = flash[:error] unless flash[:error].blank?
#    response.headers['X-Message'] = flash[:notice] unless flash[:notice].blank?
#    response.headers['X-Message'] = flash[:alert] unless flash[:alert].blank?
#    flash.discard # don't want the flash to appear when you reload page
#  end

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

  def authorize_current_user
    Authorization.current_user = current_user
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
