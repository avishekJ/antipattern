class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.string :permalink, :null => false
      t.integer :author_id, :null => false
      t.boolean :visible, :default => true
      t.integer :category_id

      t.timestamps null: false
    end
    add_index("posts", "permalink")
    add_index("posts", "author_id")
    add_index("posts", "category_id")
  end

  def down
    drop_table :posts
  end
end
