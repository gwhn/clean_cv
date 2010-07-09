class HomeController < ApplicationController
  skip_before_filter :authorize
  
  caches_page :index

  def index
    @person = Person.find(:first, :include => [:companies, :skills, :schools])
  end
end
