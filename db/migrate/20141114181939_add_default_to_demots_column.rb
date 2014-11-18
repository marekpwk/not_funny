class AddDefaultToDemotsColumn < ActiveRecord::Migration
  def change
    change_column :demots, :votes, :integer, :default => 0
  end
end
