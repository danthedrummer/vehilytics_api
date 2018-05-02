class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_one :device
  has_and_belongs_to_many :sensors
  
  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false
end
