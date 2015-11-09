require 'rails_helper'

describe Group, type: :model do
  let(:user) { create :user }

  describe "creation" do

    it "is invalid without a title" do
      group = Group.create(user: user)

      expect(group).to_not be_valid
    end

    it "is invalid with an user_id" do
      group = Group.create(title: Faker::Name.title)

      expect(group).to_not be_valid
    end

    it "is valid with a title" do
      group = Group.create(title: Faker::Name.title, user: user)

      expect(group).to be_valid
    end

  end

  describe "factory" do
    let(:group) { create :group }

    it "has a user_id" do
      expect(group.user_id).to_not be_nil
    end

    it "is valid" do
      expect(group).to be_valid
    end
  end

  describe "methods" do
    let(:group) { create :group }
    #add students ot a class, and check alpha method

    #add 3 looped separations and check loop method

  end


end