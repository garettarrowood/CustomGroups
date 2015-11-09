require 'faker'

FactoryGirl.define do
  factory :group do
    title { Faker::Name.title }
    genderfied { ["1", "0"].sample }
    user
  end
end