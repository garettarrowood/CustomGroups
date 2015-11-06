class Randomizer
  class << self
    attr_accessor :number, :group

    def number_check
      "" == @number ? @number = "3" : nil
    end

    def find_balance
      girls = @group.students.select do |student|
        "female" == student.gender
      end
      boys = @group.students.select do |student|
        "male" == student.gender  
      end
      @minority = boys.length < girls.length ? boys : girls
      @majority = boys.length >= girls.length ? boys : girls
      @students = @majority.shuffle
    end

    def full_names
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
      @group.separations.each do |separt|
        @subgroups.each do |group_number, student_array|
          if @subgroups[group_number].include?(separt.id1_to_name) && @subgroups[group_number].include?(separt.id2_to_name)
            return @switch_this = [group_number, [separt.id1_to_name, separt.id2_to_name]]
          end
        end
      end
      "pass"
    end

    def student_switcher 
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
      @subgroups[@switch_this[0]].delete(rand_student)
      another_student = @subgroups[i].sample
      @subgroups[@switch_this[0]] << another_student
      @subgroups[i].delete(another_student)
      @subgroups[i] << rand_student
    end

    def display
      number_check
      if "1" == @group.genderfied 
        find_balance
        full_names
        establish_subgroups
        spread_minority
        until @full_names.length < @number.to_i do
          distribute_one_more_iteration
        end
        distribute_leftovers
      else
        randomize_students
        full_names
        establish_subgroups
        distribute_leftovers
      end
      if separation_detector
        until "pass" == separator_checker
          student_switcher 
        end
      end
      @subgroups.each do |group_number, students_array|
        @subgroups[group_number] = students_array.shuffle
      end
    end
  end
end