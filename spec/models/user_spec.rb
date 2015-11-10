require 'rails_helper'

describe User, type: :model do

  let(:user) { create :user }

  describe "factory" do
    it "is valid" do
      expect(user).to be_valid
    end
  end

  describe "is invalid"  do 
    it "without a username" do
      user.username = nil

      expect(user).to_not be_valid
    end

    it "without a password" do
      user.password = nil

      expect(user).to_not be_valid
    end

    it "without a password of over 6 characters" do
      user.password = "short"

      expect(user).to_not be_valid
    end

    it "when the password and password_confirmation do not match" do
      user.password = "right_password"
      user.password_confirmation = "wrong_password"

      expect(user).to_not be_valid
    end
  end

end
