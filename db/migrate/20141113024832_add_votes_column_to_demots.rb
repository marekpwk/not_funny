class AddVotesColumnToDemots < ActiveRecord::Migration
  def change
    add_column :demots, :votes, :integer
  end
end
