class Template < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates :image, presence: true
  validates :user, presence: true
  validates :title, presence: true
  def self.search(query)
    if query
      where('title ILIKE  ?', "%#{query.downcase}%")
    else
      all
    end
  end
end
