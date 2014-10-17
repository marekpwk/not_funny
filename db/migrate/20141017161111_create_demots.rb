class CreateDemots < ActiveRecord::Migration
  def change
    create_table :demots do |t|
      t.string :title
      t.string :image
      t.integer :user_id
      t.timestamps
    end
  end
end
