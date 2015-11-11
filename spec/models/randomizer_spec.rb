require 'rails_helper'

describe Randomizer, type: :model do
  let(:group) { create :group, genderfied: "0" }
  let!(:student) { create :student,
    first_name: "Garett", 
    last_name: "Arrowood", 
    gender: "male", 
    group: group }

  i=1
  20.times do
    let!("student#{i}") { create :student, group: group }
    i+=1
  end

  before do
    Randomizer.group = group
    Randomizer.number = 3
  end

  describe ".full_names" do
    it "returns full names of every student" do
      expect(Randomizer.full_names(group.students)).to include("Garett Arrowood")
      expect(Randomizer.full_names(group.students).length).to eq 21
    end
  end

  describe '.establish_subgroups' do
    it "creates @subgroups hash" do
      expect(Randomizer.subgroups).to be_nil
      Randomizer.establish_subgroups(group.students)
      expect(Randomizer.subgroups).to be_an_instance_of(Hash)
    end

    it "@number determines amount of @subgroups" do
      Randomizer.establish_subgroups(group.students)
      expect(Randomizer.subgroups).to have_key("1")
      expect(Randomizer.subgroups).to have_key("2")
      expect(Randomizer.subgroups).to have_key("3")
      expect(Randomizer.subgroups).to_not have_key("4")
    end

    describe 'if students are divisible by @number' do
      it 'returns empty array' do
        established = Randomizer.establish_subgroups(group.students)
        expect(established).to eq([])
      end
    end

    describe 'if students are not divisible by @number' do 
      let!(:extra_student1) { create :student, group: group }
      let!(:extra_student2) { create :student, group: group }

      it 'returns full_names of extra students' do
        established = Randomizer.establish_subgroups(group.students)
        expect(established.length).to eq(2)
        expect(established[0]).to be_an_instance_of(String)
      end
    end
  end

  describe '@subgroups' do
    let(:group2) { create :group }
    let!(:student0) { create :student,
      first_name: "Kelly", 
      last_name: "Ryan",  
      group: group2 }
    let!(:studentX) { create :student,
      first_name: "Joe",
      last_name: "Biden",
      group: group2 }

    before do
      Randomizer.group = group2
      Randomizer.number = 2
      Randomizer.establish_subgroups(group2.students)
    end

    it "is a hash" do
      expect(Randomizer.subgroups).to be_an_instance_of(Hash)
    end

    it "with values as arrays" do
      expect(Randomizer.subgroups["1"]).to be_an_instance_of(Array)
    end

    it "that hold full_names of students" do
      expect(Randomizer.subgroups["1"][0]).to eq("Kelly Ryan")
    end
  end

  describe 'group_shuffler' do

    before do
      Randomizer.establish_subgroups(group.students)
    end

    it 'shuffles full_names in subgroups' do
      subgroups = Randomizer.subgroups
      subgroup_1 = subgroups["1"]
      expect(Randomizer.group_shuffler(subgroups)["1"]).to match_array(subgroup_1)
      expect(Randomizer.group_shuffler(subgroups)["1"]).not_to eq(subgroup_1)
    end
  end

  describe ".separator_finder" do
  end

  describe ".sort" do
    describe "randomizes students in subgroups based on conditions" do
      it "divides @subgroups roughly equal in size" do
        group_size = group.students.length
        expect(Randomizer.sort["1"].length).to be_within(1).of(group_size/3)
        expect(Randomizer.sort["2"].length).to be_within(1).of(group_size/3)
      end

      describe "calls appropriate gender method" do
        it "is not set to gender mixed" do
          expect(Randomizer).to receive(:totally_random)
          Randomizer.sort
        end

        it "is set to gender mixed" do
          group.genderfied = "1"
          expect(Randomizer).to receive(:gender_mixed)
          Randomizer.sort
        end
      end

      
    end
  end
end
