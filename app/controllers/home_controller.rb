class HomeController < ApplicationController
  skip_before_filter :authorize
  
  caches_page :index
  cache_sweeper :cv_sweeper, :only => [:create, :update, :destroy]

  def index
    @person = Person.find(:first, :include => [:companies, :skills, :schools])
  end
end
