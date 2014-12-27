class AddTotalVotesToDemots < ActiveRecord::Migration
  def change
    add_column :demots, :total_votes, :integer, default: 0
  end
end
