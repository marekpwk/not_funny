class AddApproveToDemots < ActiveRecord::Migration
  def change
    add_column :demots, :approved, :boolean, default: false
  end
end
