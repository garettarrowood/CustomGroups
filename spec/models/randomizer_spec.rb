require 'rails_helper'

describe Randomizer, type: :model do
  let(:group) { create :group }
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

  describe ".full_names(students)" do
    it "returns full names of every student in argument" do
      expect(Randomizer.full_names(group.students)).to include("Garett Arrowood")
      expect(Randomizer.full_names(group.students).length).to eq 21
    end
  end

  describe ".sort" do

    before do
      Randomizer.group = group
      Randomizer.number = 3
    end

    describe "equates as" do 
      it "a hash" do
        expect(Randomizer.sort).to be_an_instance_of(Hash)
      end

      it "with subgroups as arrays" do
        expect(Randomizer.sort["1"]).to be_an_instance_of(Array)
      end
    end

    describe "can create 2 random groups" do

      before do
        Randomizer.number = 2
      end

      describe "result" do
        it "forms two subgroups" do
          expect(Randomizer.sort).to have_key("1")
          expect(Randomizer.sort).to have_key("2")
          expect(Randomizer.sort).to_not have_key("3")
        end

        it "subgroups are roughly equal in size" do
          group_size = group.students.length
          expect(Randomizer.sort["1"].length).to be_within(1).of(group_size/2)
          expect(Randomizer.sort["2"].length).to be_within(1).of(group_size/2)
        end
      end

      it "with no separations and no gender mixed setting" do
        group.genderfied = "0"
        expect(Randomizer.sort)
      end

      it "with no separations and gender mixed setting" do

      end

      it "with 1 separation and no gender mixed setting" do

      end

      it "with 1 separation and gender mixed setting" do

      end

      it "with 3 separations and no gender mixed setting" do

      end

      it "with 3 separations and gender mixed setting" do

      end
    end

    describe "create 3 randomized subgroups of students" do
      it "with no separations and no gender mixed setting" do

      end

      it "with no separations and gender mixed setting" do

      end

      it "with 1 separation and no gender mixed setting" do

      end

      it "with 1 separation and gender mixed setting" do

      end

      it "with 3 separations and no gender mixed setting" do

      end

      it "with 3 separations and gender mixed setting" do

      end
    end

    describe "create 4 randomized subgroups of students" do
      it "with no separations and no gender mixed setting" do

      end

      it "with no separations and gender mixed setting" do

      end

      it "with 1 separation and no gender mixed setting" do

      end

      it "with 1 separation and gender mixed setting" do

      end

      it "with 3 separations and no gender mixed setting" do

      end

      it "with 3 separations and gender mixed setting" do

      end
    end
  end
 #set number and group to class


end