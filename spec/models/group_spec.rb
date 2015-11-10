require 'rails_helper'

describe Group, type: :model do
  let(:user) { create :user }

  describe "creation" do
    it "is invalid without a title" do
      group = Group.create(user: user)

      expect(group).to_not be_valid
    end

    it "is invalid without an associated user" do
      group = Group.create(title: Faker::Name.title)

      expect(group).to_not be_valid
    end

    it "is valid with a title" do
      group = Group.create(title: Faker::Name.title, user: user)

      expect(group).to be_valid
    end
  end

  describe "factory" do
    it "is valid" do
      expect(group).to be_valid
    end
  end

  let(:group) { create :group }
  let!(:student1) { Student.create(first_name: "Derek", last_name: "Zoolander", gender: "male", group: group) }
  let!(:student2) { Student.create(first_name: "Emily", last_name: "Marmaduke", gender: "female", group: group) }
  let!(:student3) { Student.create(first_name: "Garett", last_name: "Arrowood", gender: "male", group: group) }

  describe "#alpha_students" do
    it "orders students alphabetically by last name" do
      expect(group.alpha_students).to eq([student3, student2, student1])
    end
  end

  describe "#randomized_students" do
    it "shuffles students" do
      mixed_up = group.randomized_students

      expect(mixed_up).to include(student1, student2, student3)
    end
  end

  describe "separates students by gender" do
    describe "#girls" do
      it "returns female students" do
        expect(group.girls).to eq([student2])
      end
    end

    describe "#boys" do
      it "returns male students" do
        expect(group.boys).to eq([student1, student3])
      end
    end

    describe "when student genders are unbalanced" do
      it "#minority returns the students of less represented gender" do
        expect(group.minority).to eq([student2])
      end

      it "#majority returns the students of more represented gender" do
        expect(group.majority).to eq([student1, student3])
      end
    end

    describe "when student genders are equally represented" do
      let!(:student4) { create :student, gender: "female", group: group }

      it "#minority returns female students" do
        expect(group.minority).to eq([student2, student4])
      end

      it "#majority returns male students" do
        expect(group.majority).to eq([student1, student3])
      end
    end
  end

  let!(:separation1) { Separation.create(person1_id: 1, person2_id: 2, group: group) }
  let!(:separation2) { Separation.create(person1_id: 1, person2_id: 3, group: group) }

  describe "#check_loop_scenario returns false" do
    it "if there are not exactly 3 separations for group" do
      expect(group.check_loop_scenario).to be false
    end

    let!(:separation3) { Separation.create(person1_id: 1, person2_id: 4, group: group) }

    it "if all 3 students could be grouped within 2 subgroups" do
      expect(group.check_loop_scenario).to be false
    end
  end

  describe "#check_loop_scenario returns true" do
    let!(:separation3) { Separation.create(person1_id: 2, person2_id: 3, group: group) }

    it "if all 3 students separations can not be grouped together" do 
      expect(group.check_loop_scenario).to be true
    end
  end
end

