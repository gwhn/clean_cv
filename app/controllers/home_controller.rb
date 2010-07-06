class HomeController < ApplicationController
  def index
    @person = Person.find(:first, :include => [:companies, :skills, :schools])
  end

end
