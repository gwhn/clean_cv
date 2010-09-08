class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories, :force => true do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end

    add_column :skills, :category_id, :integer
  end

  def self.down
    remove_column :skills, :category_id

    drop_table :categories
  end
end
