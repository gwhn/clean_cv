class AssociateResponsibilitiesWithCompany < ActiveRecord::Migration
  def self.up
    add_column :responsibilities, :company_id, :integer, :null => false, :default => 0,
               :options => 'CONSTRAINT fk_responsibility_company REFERENCES companies(id)'
    remove_column :responsibilities, :project_id
  end

  def self.down
    add_column :responsibilities, :project_id, :integer, :null => false, :default => 0,
               :options => 'CONSTRAINT fk_responsibility_project REFERENCES projects(id)'
    remove_column :responsibilities, :company_id
  end
end
