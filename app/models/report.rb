class Report < ApplicationRecord
  has_many :readings
  belongs_to :device
  
  validates_presence_of :time_reported
end
