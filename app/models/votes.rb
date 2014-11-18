class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :demot
  validate :user_validator, on: :create
  binding.pry


  def user_validator
    binding.pry
    if Demot.find(user)
      false
    else
      true
    end
  end
end
