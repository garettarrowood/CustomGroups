class Group < ActiveRecord::Base
  has_many :students, dependent: :delete_all
  has_many :separations, dependent: :delete_all
  belongs_to :user

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

end
