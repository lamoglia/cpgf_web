FactoryGirl.define do
  factory :subordinated_organ do
    code  { "#{Faker::Number.number(5)}" }
    name  { Faker::Lorem.sentence(3, true, 1).upcase }
  end
end
