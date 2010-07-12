class HomeController < ApplicationController
  skip_before_filter :authorize
  
  caches_action :index

  def index
    @person = Person.find(:first, :include => [:companies, :skills, :schools])
    redirect_to(:action => :show, :name => @person.to_param)
  end

  def show
    @person = Person.find_by_id(params[:name].to_i)
  end
end
