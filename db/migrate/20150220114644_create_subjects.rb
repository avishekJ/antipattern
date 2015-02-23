class CreateSubjects < ActiveRecord::Migration
  def up
    create_table :subjects do |t|
      t.string :name, :null => false, :limit => 25
      t.integer :position
      t.boolean :visible, :default => false
      t.string :permalink, :null => false
      t.timestamps null: false
    end
    add_index("subjects", "permalink")
  end

  def down
  	drop_table :subjects
  end
end
