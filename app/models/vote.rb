class Vote < ActiveRecord::Base
  belongs_to :demot
  belongs_to :user
end
