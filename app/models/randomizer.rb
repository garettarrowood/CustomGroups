class Randomizer
  class << self
    attr_accessor :number, :group, :subgroups

    def full_names(students)
      students.collect do |student|
        student.full_name
      end
    end

    def establish_subgroups(students)
      names_array = full_names(students)
      @subgroups = names_array.group_by {|name| (names_array.index(name) % @number.to_i) + 1 }
    end

    def spread_minority(students)
      minority_names = full_names(students)
      minority_spread = minority_names.group_by {|name| (minority_names.index(name) % @number.to_i) + 1 }
      @subgroups.merge!(minority_spread) {|group_num, subStudents, minStudents| subStudents + minStudents }
      balance_subgroups
    end

    def balance_subgroups
      comparisons = @number.to_i / 2
      i = 1
      comparisons.times do 
        if @subgroups[i].length > @subgroups[@number.to_i + 1 - i ].length + 1
          student = @subgroups[i].shift
          @subgroups[@number.to_i + 1 - i ]<< student
        end
        i+=1
      end
    end

    def separator_finder(student_groups)
      @group.separations.each do |separation|
        student_groups.each do |group_number, student_array|
          if student_groups[group_number].include?(separation.id1_to_name) && student_groups[group_number].include?(separation.id2_to_name)
            switch_this = [group_number, [separation.id1_to_name, separation.id2_to_name]]
          end
        end
      end
      defined?(switch_this) ? @switch_this = switch_this : "pass"
    end

    def student_switcher(student_groups)
      if @group.separations.length == 3
        case @switch_this[0]
        when 1 
          i=[2, 3].sample
        when 2
          i=[1, 3].sample
        else
          i=[1, 2].sample
        end
      else 
        @switch_this[0] == 1 ? i=2 : i=1
      end
      rand_student = @switch_this[1].sample
      student_groups[@switch_this[0]].delete(rand_student)
      another_student = student_groups[i].sample
      student_groups[@switch_this[0]] << another_student
      student_groups[i].delete(another_student)
      student_groups[i] << rand_student
    end

    def group_shuffler(student_groups)
      student_groups.each do |group_number, students_array|
        student_groups[group_number] = students_array.shuffle
      end
    end

    def separator(student_groups)
      if @group.separation_detector
        until "pass" == separator_finder(student_groups)
          student_switcher(student_groups)
        end
      end
      student_groups
    end

    def gender_mixed
      establish_subgroups(@group.majority.shuffle)
      spread_minority(@group.minority.shuffle)
    end

    def totally_random
      establish_subgroups(@group.students.shuffle)
    end

    def sort
      "1" == @group.genderfied ? gender_mixed : totally_random
      group_shuffler(separator(@subgroups))
    end
  end
end