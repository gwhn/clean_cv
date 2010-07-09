class CVSweeper < ActionController::Caching::Sweeper
  observe Person, Company, Project, Responsibility, Skill, School

  def after_create
    expire_home_index
  end

  def after_update
    expire_home_index
  end

  def after_destroy
    expire_home_index    
  end

  private
  def expire_home_index
    expire_page :controller => 'home', :action => 'index'
  end
end