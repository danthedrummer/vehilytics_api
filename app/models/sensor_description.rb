class SensorDescription < ApplicationRecord
  belongs_to :sensor
  
  validates_presence_of :info
end
