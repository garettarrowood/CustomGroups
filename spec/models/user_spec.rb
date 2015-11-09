require 'rails_helper'

describe User, type: :model do
  describe "creation"  do 

    it "needs a username" do
      user = User.create(password: "example_password")

      expect(user).to_not be_valid
    end

    it "needs a password" do
      user = User.create(username: Faker::Name.name)

      expect(user).to_not be_valid
    end

    it "needs a password of over 6 characters" do
      user = User.create(
        username: Faker::Name.name, 
        password: "short")

      expect(user).to_not be_valid

      user2 = User.create(
        username: Faker::Name.name, 
        password: "long_enough")

      expect(user2).to be_valid
    end

    it "needs password and password_confirmation to match" do
      user = User.create(
        username: Faker::Name.name,
        password: "right_password",
        password_confirmation: "wrong_password")

      expect(user).to_not be_valid

      user2 = User.create(
        username: Faker::Name.name,
        password: "right_password",
        password_confirmation: "right_password")

      expect(user2).to be_valid
    end
  end

  describe "factory" do
    let(:user) { create :user }

    it "is valid" do
      expect(user).to be_valid
    end
  end

end

# let(:user) { create :user }