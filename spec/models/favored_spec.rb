require 'rails_helper'

RSpec.describe Favored, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:favored)).to be_valid
  end
end
