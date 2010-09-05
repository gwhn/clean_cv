class CvSweeper < ActionController::Caching::Sweeper
  observe Person, Company, Project, Responsibility, Skill, School, Task

  def after_create(record)
    expire_page root_url
  end

  def after_update(record)
    expire_page root_url
  end

  def after_destroy(record)
    expire_page root_url
  end
end