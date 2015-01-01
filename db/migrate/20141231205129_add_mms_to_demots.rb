class AddMmsToDemots < ActiveRecord::Migration
  def change
    add_column :demots, :mms, :boolean, default: false
  end
end
