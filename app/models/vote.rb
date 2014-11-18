class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :demot
  validate :user_validator, on: :create


  def user_validator
    # binding.pry
    if demot.voters.ids.include?(user.id)
      errors.add(:user_id, "already voted")
    end
  end
end
