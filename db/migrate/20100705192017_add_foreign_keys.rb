class AddForeignKeys < ActiveRecord::Migration
  def self.up
    add_column :companies, :person_id, :integer, :null => false, :default => 0,
               :options => 'CONSTRAINT fk_company_person REFERENCES people(id)'
    add_column :projects, :company_id, :integer, :null => false, :default => 0,
               :options => 'CONSTRAINT fk_project_company REFERENCES companies(id)'
    add_column :responsibilities, :project_id, :integer, :null => false, :default => 0,
               :options => 'CONSTRAINT fk_responsibility_project REFERENCES projects(id)'
    add_column :skills, :person_id, :integer, :null => false, :default => 0,
               :options => 'CONSTRAINT fk_skill_person REFERENCES people(id)'
    add_column :schools, :person_id, :integer, :null => false, :default => 0,
               :options => 'CONSTRAINT fk_school_person REFERENCES people(id)'
  end

  def self.down
    remove_column :schools, :person_id
    remove_column :skills, :person_id
    remove_column :responsibilities, :project_id
    remove_column :projects, :company_id
    remove_column :companies, :person_id
  end
end
