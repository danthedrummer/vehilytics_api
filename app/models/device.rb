class Device < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :user, optional: true
  has_many :reports
  has_and_belongs_to_many :sensors
  
  validates_presence_of :email, :device_name
  validates_uniqueness_of :email, :device_name
end
