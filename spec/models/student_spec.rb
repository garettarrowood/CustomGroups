require 'rails_helper'

describe Student, type: :model do
  let(:user) { create :user }
  let(:group) { create :group }
  let(:student) { create :student }

  describe "factory" do
    it "is valid" do
      expect(student).to be_valid
    end
  end

  describe "is invalid" do
    it "without a first name" do
      student.first_name = nil

      expect(student).to_not be_valid
    end

    it "without a last name" do
      student.last_name = nil

      expect(student).to_not be_valid
    end

    it "without a gender" do
      student.gender = nil

      expect(student).to_not be_valid
    end

    it "without an associated group" do
      student.group_id = nil

      expect(student).to_not be_valid
    end
  end

  describe "#full_name" do
    it "returns its full name" do
      student.first_name = "Garett"
      student.last_name = "Arrowood"

      expect(student.full_name).to eq("Garett Arrowood")
    end
  end
end


