class CreateProjectsSkillsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :projects_skills, :id => false do |t|
      t.integer :project_id
      t.integer :skill_id
    end
  end

  def self.down
    drop_table :projects_skills
  end
end
