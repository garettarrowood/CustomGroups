class Student < ActiveRecord::Base
  belongs_to :group
  validates :first_name, :last_name, :gender, :group, presence: true
end
