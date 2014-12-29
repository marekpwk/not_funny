class User < ActiveRecord::Base
  has_many :demots
  has_many :votes
  before_create :create_remember_token
  before_save { email.downcase! }

  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
    format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  validate :password, length: {minimum: 6}
  self.per_page = 20
  private
  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def self.search(query)
    if query
      where('name ILIKE  ?', "%#{query.downcase}%")
    else
      all
    end
  end
end
