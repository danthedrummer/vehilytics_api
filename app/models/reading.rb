class Reading < ApplicationRecord
  belongs_to :sensor
  belongs_to :report
  
  validates_presence_of :value
end
