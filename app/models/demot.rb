class Demot < ActiveRecord::Base
  belongs_to :user, foreign_key: "user_id"
  has_many :comments, as: :commentable, :dependent => :destroy
  mount_uploader :image, ImageUploader
  validates :image, presence: true
  validates :user, presence: true
  validates :title, presence: true
  has_many :votes
  has_many :voters, through: :votes, source: :user

  def self.search(query)
    if query
      where('title ILIKE  ?', "%#{query.downcase}%")
    else
      all
    end
  end
end
