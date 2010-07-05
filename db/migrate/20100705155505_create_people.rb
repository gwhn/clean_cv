class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.string :job_title
      t.string :email
      t.string :phone
      t.string :mobile
      t.string :portrait_url
      t.text :profile

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
