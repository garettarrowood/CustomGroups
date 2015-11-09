require 'rails_helper'

describe User, type: :model do
  describe "creation"  do 

    it "needs a username" do
      user = User.new(password: "example_password")

      user.save
      expect(user).to_not be_valid
    end

    it "needs a password" do
      user = User.new(username: Faker::Name.name)

      user.save
      expect(user).to_not be_valid
    end

    it "needs a password of over 6 characters" do
      user = User.new(username: Faker::Name.name, password: "short")

      user.save
      expect(user).to_not be_valid

      user2 = User.new(username: Faker::Name.name, password: "long_enough")

      user2.save
      expect(user2).to be_valid
    end
  end

  describe "authentication" do

  end

  describe "factory" do
    let(:user) { create :user }

    it "is valid" do
      expect(user).to be_valid
    end
  end
end

# let(:user) { create :user }