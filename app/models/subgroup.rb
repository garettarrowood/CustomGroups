class Subgroup

  attr_accessor :factions, :group

  def initialize(number, group)
    @number = number
    @group = group
    "1" == @group.genderfied ? gender_mixed : totally_random
  end

  def full_names(students)
    students.collect do |student|
      student.full_name
    end
  end

  def establish_factions(students)
    names_array = full_names(students)
    @factions = names_array.group_by {|name| (names_array.index(name) % @number.to_i) + 1 }
  end

  def spread_minority(students)
    minority_names = full_names(students)
    minority_spread = minority_names.group_by {|name| (minority_names.index(name) % @number.to_i) + 1 }
    @factions.merge!(minority_spread) {|group_num, subStudents, minStudents| subStudents + minStudents }
    balance_factions
  end

  def balance_factions
    comparisons = @number.to_i / 2
    i = 1
    comparisons.times do 
      if @factions[i].size > @factions[@number.to_i + 1 - i ].size + 1
        student = @factions[i].shift
        @factions[@number.to_i + 1 - i ]<< student
      end
      i+=1
    end
  end

  def gender_mixed
    establish_factions(@group.majority.shuffle)
    spread_minority(@group.minority.shuffle)
  end

  def totally_random
    establish_factions(@group.students.shuffle)
  end

end
