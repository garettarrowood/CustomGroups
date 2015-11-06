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

  def check_redundancies
    group = Group.find(group_id)
    if group.separations != []
      group.separations.each do |separt|
        if person1_id == separt.person1_id && person2_id == separt.person2_id
          return true
        elsif person1_id == separt.person2_id && person2_id == separt.person1_id
          return true
        end
      end
    end
    false
  end

end
