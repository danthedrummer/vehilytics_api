class Sensor < ApplicationRecord
  has_many :readings
  has_and_belongs_to_many :devices
end
