class AddTotalVotesToDemots < ActiveRecord::Migration
  def change
    add_column :demots, :total_votes, :integer
  end
end
