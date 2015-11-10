require 'faker'

FactoryGirl.define do
  factory :separation do
    person1_id { Faker::Number.between(1, 10) }
    person2_id { Faker::Number.between(11, 20) }
    group
  end
end