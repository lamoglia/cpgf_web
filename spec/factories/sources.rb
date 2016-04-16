FactoryGirl.define do
  factory :source do
    sequence(:file_name) { |n| "file_#{n}.csv" }
    sequence(:reference) { |n| n.months.from_now }
    imported_at { Faker::Time.backward(30) }
  end
end
