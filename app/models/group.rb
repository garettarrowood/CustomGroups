class Group < ActiveRecord::Base
  has_many :students, dependent: :delete_all
  has_many :separations, dependent: :delete_all
  belongs_to :user

  validates :title, :user, presence: true

  def check_loop_scenario
    if separations.length == 3
      used_ids = []
      separations.each do |separt|
        used_ids << separt.person1_id
        used_ids << separt.person2_id
      end
      if used_ids.uniq.length == 3
        return true
      end
    end
    false
  end

  def alpha_students
    students.sort { |a,b| a.last_name.downcase <=> b.last_name.downcase }
  end

end
