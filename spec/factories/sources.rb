FactoryGirl.define do
  factory :source do
    file_name "#{Faker::Hipster.word}.csv"
    reference Faker::Date.backward(30)
    imported_at Faker::Time.backward(30)
  end
end
