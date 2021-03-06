require 'digest/sha1'

class User < ActiveRecord::Base

  has_and_belongs_to_many :events
  
  attr_accessor :password
  
	validates_uniqueness_of :email
  validates_length_of :password, :within => 6..25, :on => :create
	validates_presence_of :email, :password, :first_name, :last_name
	validates_format_of :email,
	    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  before_save :create_hashed_password
  after_save :clear_password
  
  attr_protected :hashed_password, :salt
  
  def self.authenticate(email="", password="")
    user = User.find_by_email(email)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end
  
  def password_match?(password="")
    hashed_password == User.hash_with_salt(password, salt)
  end
  
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Hey #{username}, when would you like your salt? How about #{Time.now}?")
  end
  
  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("I like a #{salt}y #{password}");
  end
  
  private
  def create_hashed_password
    unless password.blank?
      self.salt = User.make_salt(:email) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end
  
  def clear_password
    self.password = nil
  end

end
