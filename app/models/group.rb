class Group < ActiveRecord::Base
  has_many :students, dependent: :delete_all
  has_many :separations, dependent: :delete_all
  belongs_to :user

end
