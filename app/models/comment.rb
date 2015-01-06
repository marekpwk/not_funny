class Comment < ActiveRecord::Base
  has_ancestry
  belongs_to :demot
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
end
