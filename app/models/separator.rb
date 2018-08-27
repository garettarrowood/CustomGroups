class Separator

  def initialize(subgroup)
    @factions = subgroup.factions
    @group = subgroup.group
  end


  def separator(student_groups)
    return student_groups unless @group.separation_detector
    until "pass" == conflict_info = separation_finder(student_groups)
      student_switcher(student_groups, conflict_info)
    end
    student_groups
  end

  def separation_finder(student_groups)
    switch_this = "none needed"
    @group.separations.each do |separation|
      student_groups.each do |group_num, student_array|
        next unless (student_groups[group_num].include?(separation.id1_to_name) && student_groups[group_num].include?(separation.id2_to_name))
        switch_this = [group_num, [separation.id1_to_name, separation.id2_to_name]]
      end
    end
    switch_this != "none needed" ? switch_this : "pass"
  end

  def student_switcher(student_groups, conflict_info)
    if @group.separations.size == 3
      case conflict_info[0]
      when 1
        i=[2, 3].sample
      when 2
        i=[1, 3].sample
      else
        i=[1, 2].sample
      end
    else
      conflict_info[0] == 1 ? i=2 : i=1
    end
    rand_student = conflict_info[1].sample
    student_groups[conflict_info[0]].delete(rand_student)
    another_student = student_groups[i].sample
    student_groups[conflict_info[0]] << another_student
    student_groups[i].delete(another_student)
    student_groups[i] << rand_student
  end

  def group_shuffler(student_groups)
    student_groups.each do |group_number, students_array|
      student_groups[group_number] = students_array.shuffle
    end
  end

  def sort
    group_shuffler(separator(@factions))
  end

end
