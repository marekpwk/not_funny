class AddPhoneToDemots < ActiveRecord::Migration
  def change
    add_column :demots, :phone, :string
  end
end
