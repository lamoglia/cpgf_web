require 'rails_helper'

RSpec.describe SuperiorOrgan, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:superior_organ)).to be_valid
  end
end
