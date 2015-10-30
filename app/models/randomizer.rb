class Randomizer
  class << self
    attr_accessor :number, :group_id

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
      base_group_size = @students.length / @number.to_i
      i=1
      @number.to_i.times do
        @subgroups["#{i}"] = @full_names[0...base_group_size]  
        i += 1  
        @full_names = @full_names.drop(base_group_size)
      end
      leftovers = @students.length % @number.to_i
      i=1
      leftovers.times do
        @subgroups["#{i}"] << @full_names[0]
        @full_names = @full_names.drop(1)
        i += 1
      end
    end

    def gender_seperator
      # HIDE THIS FUNCTIONALITY IN CLASS SETTINGS
      # don't know how I'm going to handle this yet. Maybe sets boys and girls variables from randomized students. Probably has to run a pretty different randomization process to work... Fine.
    end

    def separation_detector
      # returns boolean of whether any special students need to be separated. In master opperation, when it returns false, then the class can output groups.
    end

    def separator
      # handles swap of students that need separating.  This runs until separation_detector returns correct boolean value
    end

    def display
      get_randomized_students
      if @gender_specific == "whatever it is supposed to equal"
        #run gender randomizer
      end
      set_full_names
      set_random_groups
      @subgroups
    end
  end

end