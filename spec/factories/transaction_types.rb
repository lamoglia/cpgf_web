FactoryGirl.define do
  factory :transaction_type do
    description { Faker::Lorem.sentence(3, true, 1).upcase } 
  end
end
