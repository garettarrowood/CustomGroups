require 'rails_helper'

describe User, type: :model do
  describe "creation"  do 

    it "is invalid without a username" do
      user = User.create(password: "example_password")

      expect(user).to_not be_valid
    end

    it "is invalid without a password" do
      user = User.create(username: Faker::Name.name)

      expect(user).to_not be_valid
    end

    it "is invalid without a password of over 6 characters" do
      user = User.create(
        username: Faker::Name.name, 
        password: "short")

      expect(user).to_not be_valid
    end

    it "is valid when with a username and password of over 6 characters" do
      user = User.create(
        username: Faker::Name.name, 
        password: "long_enough")

      expect(user).to be_valid
    end

    it "is invalid when the password and password_confirmation do not match" do
      user = User.create(
        username: Faker::Name.name,
        password: "right_password",
        password_confirmation: "wrong_password")

      expect(user).to_not be_valid
    end

    it "is valid when the password and password_confirmation do match" do
      user = User.create(
        username: Faker::Name.name,
        password: "right_password",
        password_confirmation: "right_password")

      expect(user).to be_valid
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