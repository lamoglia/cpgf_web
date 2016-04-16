require 'rails_helper'

RSpec.describe Favored, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:favored)).to be_valid
  end

  it "should return favored in the correct order" do
    expect(Favored.by_transactions_value.order_values).to eq(["total desc"])
  end
end
