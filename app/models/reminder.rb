class Reminder < ApplicationRecord
  validates_presence_of [:title, :weekly_frequency, :description]
  validates_uniqueness_of :title
end
