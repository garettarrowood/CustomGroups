class Group < ActiveRecord::Base
  has_many :students, dependent: :delete_all
  has_many :separations, dependent: :delete_all
  belongs_to :user

  validates :title, :user, presence: true

  def check_loop_scenario
    return false unless separations.size == 3
    used_ids = []
    separations.each do |separt|
      used_ids << separt.person1_id
      used_ids << separt.person2_id
    end
    used_ids.uniq.size == 3
  end

  def alpha_students
    students.sort { |a,b| a.last_name.downcase <=> b.last_name.downcase }
  end

  def girls
    students.select { |student| "female" == student.gender }
  end

  def boys
    students.select { |student| "male" == student.gender }
  end

  def minority
    boys.length < girls.size ? boys : girls
  end

  def majority
    boys.length >= girls.size ? boys : girls
  end

  def separation_detector
    separations != []
  end

end
