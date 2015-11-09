require 'rails_helper.rb'

describe User, type: :model do
  let(:user) { create :user }

  it "is a test" do
    expect(true).to eq(true)
  end
end