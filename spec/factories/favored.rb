FactoryGirl.define do
  factory :favored do
    name Faker::Name.name
    masked_document "***#{Faker::Number.number(5)}*-**"
  end
end
