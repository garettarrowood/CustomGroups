require 'rails_helper'

describe Student, type: :model do
  let(:user) { create :user }
  let(:group) { create :group }

  describe "creation" do

    it "is invalid without a first name" do
      student = Student.create(
        last_name: Faker::Name.last_name,
        gender: "male",
        group: group)

      expect(student).to_not be_valid
    end

    it "is invalid without a last name" do
      student = Student.create(
        first_name: Faker::Name.first_name,
        gender: "male",
        group: group)

      expect(student).to_not be_valid
    end

    it "is invalid without a gender" do
      student = Student.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        group: group)

      expect(student).to_not be_valid
    end


    it "is invalid without an associated group" do
      student = Student.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        gender: "male")

      expect(student).to_not be_valid
    end

    it "is valid with a first name, last name, gender, and an associated group" do
      student = Student.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        gender: "male",
        group: group)

      expect(student).to be_valid
    end
  end



end