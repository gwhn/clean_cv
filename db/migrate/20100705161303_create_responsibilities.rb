class CreateResponsibilities < ActiveRecord::Migration
  def self.up
    create_table :responsibilities do |t|
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :responsibilities
  end
end
