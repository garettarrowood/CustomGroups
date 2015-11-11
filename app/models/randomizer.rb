class Randomizer
  class << self
    attr_accessor :number, :group, :subgroups, :leftovers

    def full_names(students)
      students.collect do |student|
        student.full_name
      end
    end

    def spread_minority
      minority_names = full_names(@group.minority.shuffle)
      if @number.to_i < minority_names.length
        i=1
        @number.to_i.times do
          @subgroups["#{i}"] << minority_names[0]
          minority_names = minority_names.drop(1)
          i += 1
        end
      else
        i=0
        minority_names.length.times do
          @subgroups["#{@number.to_i - i}"] << minority_names[0]
          minority_names = minority_names.drop(1)
          i += 1
        end
      end
      minority_names
    end

    def establish_subgroups(students)
      @subgroups = {}
      names_array = full_names(students)
      base_group_size = names_array.length / @number.to_i
      i=1
      @number.to_i.times do
        @subgroups["#{i}"] = names_array[0...base_group_size]  
        i += 1  
        names_array = names_array.drop(base_group_size)
      end
      names_array
    end

    def one_more_iteration(student_names)
      i=1
      @number.to_i.times do
        @subgroups["#{i}"] << student_names[0]
        student_names = student_names.drop(1)
        i += 1
      end
      @leftovers = student_names
    end

    def distribute_leftovers(student_names)
      i=1
      student_names.length.times do
        @subgroups["#{i}"] << student_names[0]
        student_names = student_names.drop(1)
        i += 1
      end
      @subgroups
    end

    def separator_finder(student_groups)
      @group.separations.each do |separt|
        student_groups.each do |group_number, student_array|
          if student_groups[group_number].include?(separt.id1_to_name) && student_groups[group_number].include?(separt.id2_to_name)
            return @switch_this = [group_number, [separt.id1_to_name, separt.id2_to_name]]
          end
        end
      end
      "pass"
    end

    def student_switcher(student_groups)
      if @group.separations.length == 3
        case @switch_this[0]
        when "1" 
          i=["2", "3"].sample
        when "2"
          i=["1", "3"].sample
        else
          i=["1", "2"].sample
        end
      else 
        @switch_this[0] == "1" ? i="2" : i="1"
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
      @leftovers = establish_subgroups(@group.majority.shuffle) + spread_minority
      until @leftovers.length < @number.to_i do
        one_more_iteration(@leftovers)
      end
      distribute_leftovers(@leftovers)
    end

    def totally_random
      distribute_leftovers(establish_subgroups(@group.randomized_students))
    end

    def sort
      "1" == @group.genderfied ? gender_mixed : totally_random
      group_shuffler(separator(@subgroups))
    end
  end
end