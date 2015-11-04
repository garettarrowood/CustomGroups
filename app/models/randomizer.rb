class Randomizer
  class << self
    attr_accessor :number, :group_id

    def number_check
      if @number == ""
        @number = "2"
      end
    end

    def get_group
      @group = Group.find(@group_id)
    end

    def set_genders
      @girls = @group.students.select do |student|
        student.gender == "female"  
      end
      @boys = @group.students.select do |student|
        student.gender == "male"  
      end
    end

    def find_balance
      @minority = @boys.length < @girls.length ? @boys : @girls
      @majority = @boys.length >= @girls.length ? @boys : @girls
      @students = @majority.shuffle
    end

    def set_full_names
      @full_names = @students.collect do |student|
        "#{student.first_name} #{student.last_name}"
      end
    end

    def spread_minority
      @minority_names = @minority.shuffle.collect do |student|
        "#{student.first_name} #{student.last_name}"
      end
      if @number.to_i < @minority_names.length
        i=1
        @number.to_i.times do
          @subgroups["#{i}"] << @minority_names[0]
          @minority_names = @minority_names.drop(1)
          i += 1
        end
        @full_names << @minority_names
        @full_names.flatten!
      else
        i=0
        @minority_names.length.times do
          @subgroups["#{@number.to_i - i}"] << @minority_names[0]
          @minority_names = @minority_names.drop(1)
          i += 1
        end
      end
    end    

    def randomize_students
      @students = @group.students.shuffle
    end

    def establish_subgroups
      @subgroups = {}
      base_group_size = @full_names.length / @number.to_i
      i=1
      @number.to_i.times do
        @subgroups["#{i}"] = @full_names[0...base_group_size]  
        i += 1  
        @full_names = @full_names.drop(base_group_size)
      end
    end

    def distribute_one_more_iteration
      i=1
      @number.to_i.times do
        @subgroups["#{i}"] << @full_names[0]
        @full_names = @full_names.drop(1)
        i += 1
      end
    end

    def distribute_leftovers
      leftovers = @full_names.length
      i=1
      leftovers.times do
        @subgroups["#{i}"] << @full_names[0]
        @full_names = @full_names.drop(1)
        i += 1
      end
    end

    def separation_detector
      @group.separations != []
    end

    def separator_checker
      @separts = @group.separations
      i=0
      @separts.length.times do 
        @subgroups.each do |group_number, student_array|
          if @subgroups[group_number].include?(@separts[i].id1_to_name) && @subgroups[group_number].include?(@separts[i].id2_to_name)
            return @switch_this = [group_number, @separts[i].id1_to_name]
          end
        end
        i += 1
      end
      "pass"
    end

    def student_switcher
      @switch_this[0] == @subgroups.length.to_s ? i="1" : i=@subgroups.length.to_s
      @subgroups[@switch_this[0]].delete(@switch_this[1])
      another_student = @subgroups[i].sample
      @subgroups[@switch_this[0]] << another_student
      @subgroups[i].delete(another_student)
      @subgroups[i] << @switch_this[1]
    end

    def display
      number_check
      get_group
      if @group.genderfied == "1"
        set_genders
        find_balance
        set_full_names
        establish_subgroups
        spread_minority
        until @full_names.length < @number.to_i
          distribute_one_more_iteration
        end
        distribute_leftovers
      else
        randomize_students
        set_full_names
        establish_subgroups
        distribute_leftovers
      end
      if separation_detector
        until separator_checker == "pass"
          student_switcher # run something until the checker clears
        end
      end
      @subgroups.each do |group_number, students_array|
        @subgroups[group_number] = students_array.shuffle
      end
    end
  end
end