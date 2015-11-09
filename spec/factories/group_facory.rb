require 'faker'

FactoryGirl.define do
  factory :group do
    title { Faker::Name.title }
    genderfied { ["1", nil].sample }
  end
end