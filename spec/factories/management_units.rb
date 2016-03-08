FactoryGirl.define do
  factory :management_unit do
    code "#{Faker::Number.number(5)}"
    name Faker::Lorem.sentence(3, true, 1).upcase
  end
end
