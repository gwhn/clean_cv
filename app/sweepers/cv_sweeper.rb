class CvSweeper < ActionController::Caching::Sweeper
  observe Person, Company, Project, Responsibility, Skill, School

  def after_create(record)
    expire_home_index
  end

  def after_update(record)
    expire_home_index
  end

  def after_destroy(record)
    expire_home_index    
  end

  private
  def expire_home_index
    expire_page :controller => 'home', :action => 'index'
  end
end