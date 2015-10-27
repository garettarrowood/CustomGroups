class Group < ActiveRecord::Base
  has_many :students
  has_many :separations
  belongs_to :user
  
end
