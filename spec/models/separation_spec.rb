require 'rails_helper'

describe Separation, type: :model do
  let(:group) { create :group }
  let!(:separation) { create :separation, person1_id: 1, person2_id: 2 }

  describe "factory" do
    it "is valid" do
      expect(separation).to be_valid
    end
  end

  describe "is invalid" do
    it "without person1_id" do
      separation.person1_id = nil

      expect(separation).to_not be_valid
    end

    it "without person2_id" do
      separation.person2_id = nil

      expect(separation).to_not be_valid
    end

    it "without an associated group" do
      separation.group_id = nil

      expect(separation).to_not be_valid
    end
  end

  let!(:student1) { create :student, first_name: "Garett", last_name: "Arrowood", group: group }
  let!(:student2) { create :student, first_name: "Kelly", last_name: "Ryan", group: group }  

  describe "#id1_to_name" do
    it "prints full name of associated student" do
      expect(separation.id1_to_name).to eq "Garett Arrowood"
    end
  end

  describe "#id2_to_name" do
    it "prints full name of associated student" do
      expect(separation.id2_to_name).to eq "Kelly Ryan"
    end
  end

  describe '#check_redundancies' do
    let(:new_redundant_separation) { Separation.new(person1_id: 1, person2_id: 2, group_id: 1) }

    it 'returns true if new instance is redundant' do
      expect(new_redundant_separation.check_redundancies).to be true
    end

    let(:new_separation) { Separation.new(person1_id: 3, person2_id: 4, group_id: 1) }

    it "returns false if new instance is not redundant" do
      expect(new_separation.check_redundancies).to be false
    end
  end

end