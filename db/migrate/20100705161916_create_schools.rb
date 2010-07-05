class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :name
      t.string :course
      t.string :result
      t.date :date_from
      t.date :date_to

      t.timestamps
    end
  end

  def self.down
    drop_table :schools
  end
end
