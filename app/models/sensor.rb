class Sensor < ApplicationRecord
  has_many :readings
  has_and_belongs_to_many :devices
  has_and_belongs_to_many :users
  
  validates_presence_of :name, :shortname, :unit
  validates_uniqueness_of :name, :shortname, :case_sensitive => false
end
