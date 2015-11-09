require 'faker'

FactoryGirl.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { ["male", "female"].sample }
  end
end