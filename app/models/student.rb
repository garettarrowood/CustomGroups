class Student < ActiveRecord::Base
  belongs_to :group
  validates :first_name, :last_name, :gender, :group, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

end
