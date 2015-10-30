class Randomizer
  @gender_specific = "not assigned"
  @number = 0
  @group_id = 0

  class << self
    def gender_specific
      @gender_specific
    end

    def gender_specific=(option)
      @gender_specific = option
    end

    def number
      @number
    end

    def number=(groups)
      @number = groups
    end

    def group_id
      @group_id
    end

    def group_id=(id)
      @group_id = id
    end

    def get_randomized_students
      group = Group.find(@group_id)
      @students = group.students.shuffle
    end

    def set_full_names
      @full_names = @students.collect do |student|
        "#{student.first_name} #{student.last_name}"
      end
    end

    def set_random_groups
      @subgroups = {}
      i=1
      base_group_size = @students.length / @number.to_i
      leftovers = @students.length % @number.to_i
      @number.to_i.times do
        @subgroups["#{i}"] = @full_names[0...base_group_size]  
        i += 1  
        @full_names = @full_names.drop(base_group_size)
      end
      i=1
      leftovers.times do
        @subgroups["#{i}"] << @full_names[0]
        @full_names = @full_names.drop(1)
        i += 1
      end
    end

    def display
      get_randomized_students
      set_full_names
      set_random_groups
      @subgroups
    end
  end



end