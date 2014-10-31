class Template < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
