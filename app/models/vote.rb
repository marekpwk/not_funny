class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :demot
  validate :user_validator, on: :create
  after_save :up_total_votes
  after_destroy :down_total_votes

  def up_total_votes
    demot.update_attribute(:total_votes, demot.total_votes + 1)
  end

  def down_total_votes
    demot.update_attribute(:total_votes, demot.total_votes - 1)
  end

  def user_validator
    # binding.pry
    if demot.voters.ids.include?(user.id)
      errors.add(:user_id, "already voted")
    end
  end
end
