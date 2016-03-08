require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:transaction_type)).to be_valid
  end
end
