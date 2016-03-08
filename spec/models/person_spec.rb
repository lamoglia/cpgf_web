require 'rails_helper'

RSpec.describe Person, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:person)).to be_valid
  end
end
