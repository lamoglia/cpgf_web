require 'rails_helper'

RSpec.describe Person, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:person)).to be_valid
  end

  it "should return people in the correct order" do
    expect(Person.by_transactions_value.order_values).to eq(["total desc"])
  end

  context 'scopes' do
    before(:all) do
      @pessoa1 = FactoryGirl.create :person, :with_transactions, :number_of_transactions => 4
      @pessoa2 = FactoryGirl.create :person, :with_transactions, :number_of_transactions => 1
    end

    it "should group transactions by person" do
      expect(Person.by_transactions_value.length).to eq(2)
    end

    it "should order by total" do
      result = Person.by_transactions_value

      expect(result.first.total).to be >= result.second.total
    end

    it "should be the sum of transactions" do
      result = Person.by_transactions_value

      sum = 0
      result.first.transactions.each do |t|
        sum += t.value
      end
      
      expect(result.first.total).to eq sum
    end
  end
end
