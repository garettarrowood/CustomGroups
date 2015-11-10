require 'rails_helper'

describe Randomizer, type: :model do
  let(:group) { create :group }
  let!("model_student") { Student.create(
    first_name: "Garett", 
    last_name: "Arrowood", 
    gender: "male", 
    group: group)}

  i=1
  20.times do
    let!("student#{i}") { create :student, group: group }
    i+=1
  end

  describe ".full_names(students)" do
    it "returns full names of every student in argument" do
      expect(Randomizer.full_names(group.students)).to include("Garett Arrowood")
      expect(Randomizer.full_names(group.students).length).to eq 21
    end
  end
 #set number and group to class


end