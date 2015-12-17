class Separation < ActiveRecord::Base
  belongs_to :group

  validates :person1_id, :person2_id, :group, presence: true

  def id1_to_name
    Student.find(person1_id).full_name
  end

  def id2_to_name
    Student.find(person2_id).full_name
  end

  def check_redundancies
    group = Group.find(group_id)
    return false if group.separations == []
    group.separations.each do |separt|
      if (person1_id == separt.person1_id && person2_id == separt.person2_id) || (person1_id == separt.person2_id && person2_id == separt.person1_id)
        return true
      end
    end
    false
  end

end
