require 'rails_helper'

describe Separation, type: :model do
  let(:group) { create :group }

  describe "creation" do
    it "is invalid without person1_id" do
      separation = Separation.create(person2_id: 2, group: group)

      expect(separation).to_not be_valid
    end

    it "is invalid without person2_id" do
      separation = Separation.create(person1_id: 1, group: group)

      expect(separation).to_not be_valid
    end

    it "is invalid without an associated group" do
      separation = Separation.create(person1_id: 1, person2_id: 2)

      expect(separation).to_not be_valid
    end

    it "is valid with a person1_id, person2_id, and group" do
      separation = Separation.create(
        person1_id: 1, 
        person2_id: 2,
        group: group)

      expect(separation).to be_valid     
    end
  end

  let!(:student1) { Student.create(first_name: "Garett", last_name: "Arrowood", gender: "male", group: group) }
  let!(:student2) { Student.create(first_name: "Kelly", last_name: "Ryan", gender: "female", group: group) }  
  let!(:separation) { Separation.create(person1_id: 1, person2_id: 2, group: group) }

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
    let(:new_separation) { Separation.new(person1_id: 3, person2_id: 4, group: group) }

    it "returns false if new instance is not redundant" do
      expect(new_separation.check_redundancies).to be false
    end

    let(:new_redundant_separation) { Separation.new(person1_id: 1, person2_id: 2, group: group) }

    it 'returns true if new instance is redundant' do
      expect(new_redundant_separation.check_redundancies).to be true
    end
  end

end