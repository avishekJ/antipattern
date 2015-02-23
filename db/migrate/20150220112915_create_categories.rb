class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.string 	:name, :limit => 25, :null => false
      t.text 	:description
      t.integer :subject_id, :null => false
      t.string :permalink, :null => false
      t.integer :parent_id
      t.boolean :visible, :default => false

      t.timestamps null: false
    end
    add_index('categories', 'subject_id')
    add_index("categories", "permalink")
  end

  def down 
  	drop_table :categories
  end
end
