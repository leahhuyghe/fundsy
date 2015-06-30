class User < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password_digest, presence: true
  validates :password, presence: true

  def full_name
    "#{first_name} #{last_name}".strip
  end

  

end
