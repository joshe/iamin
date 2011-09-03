require 'digest/sha1'
class Event < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  
  geocoded_by :address
  after_validation :geocode
  
  validates :threshold, :presence => true
  validates :max, :presence => true
end
