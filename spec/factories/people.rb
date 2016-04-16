FactoryGirl.define do
  factory :person do
    name            { Faker::Name.name }
    masked_document { "***#{Faker::Number.number(5)}*-**" }
  end

  trait :with_transactions do
    transient do
      number_of_transactions 3
    end
    
    after :create do |person, evaluator|
      FactoryGirl.create_list :transaction, evaluator.number_of_transactions, :person => person
    end
  end
end
