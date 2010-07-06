class HomeController < ApplicationController
  caches_page :index

  def index
    @person = Person.find(:first, :include => [:companies, :skills, :schools])
  end
end
