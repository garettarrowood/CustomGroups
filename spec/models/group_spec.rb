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

  let(:group) { create :group }

  describe "factory" do

    it "is valid" do
      expect(group).to be_valid
    end
  end

  describe "methods" do
    #add students ot a class, and check alpha method

    #add 3 looped separations and check loop method

  end


end