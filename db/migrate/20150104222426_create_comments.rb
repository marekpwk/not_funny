class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.string :user_id
      t.text :body

      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
