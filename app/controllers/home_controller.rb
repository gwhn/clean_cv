class HomeController < ApplicationController
  def index
    @person = Person.find(:first)
  end

end
