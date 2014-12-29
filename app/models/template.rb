class Template < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user

  def self.search(query)
    if query
      where('title ILIKE  ?', "%#{query.downcase}%")
    else
      all
    end
  end
end
