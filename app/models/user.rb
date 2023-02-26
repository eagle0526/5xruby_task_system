class User < ApplicationRecord
  validates :email, presence: true
  validates :password, confirmation: true, length: {minimum: 8}
  
  has_many :tasks

  before_create :encrypt_password 


  def self.login(email, password)
    hashed_password = Digest::SHA1.hexdigest("add#{password}salt")
    find_by(email: email, password: hashed_password)
  end

  private
  
  def encrypt_password
    self.password = Digest::SHA1.hexdigest("add#{self.password}salt")
  end
end
