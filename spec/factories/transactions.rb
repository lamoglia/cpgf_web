FactoryGirl.define do
  factory :transaction do
    value Faker::Commerce.price
    date Faker::Date.backward(14)
    superior_organ 
    subordinated_organ 
    management_unit 
    source 
    person
    favored 
    transaction_type 
  end
end
