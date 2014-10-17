class Demot < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
