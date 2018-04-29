class Report < ApplicationRecord
  has_many :readings
  belongs_to :device
end
