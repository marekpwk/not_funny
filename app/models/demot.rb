class Demot < ActiveRecord::Base
 belongs_to :user
  mount_uploader :image, ImageUploader
 validates :image, presence: true
 validates :user, presence: true
end
