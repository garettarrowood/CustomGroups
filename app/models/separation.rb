class Separation < ActiveRecord::Base
  belongs_to :group

  def id1_to_name
    student = Student.find(person1_id)
    "#{student.first_name} #{student.last_name}"
  end

  def id2_to_name
    student = Student.find(person2_id)
    "#{student.first_name} #{student.last_name}"
  end
end
