class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.string :contact_no
      t.integer :author_id
      t.timestamps null: false
    end
    add_index('profiles', 'author_id')
  end
end
