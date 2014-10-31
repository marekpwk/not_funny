class AddTypeToDemots < ActiveRecord::Migration
  def change
    add_column :demots, :type, :string
  end
end
