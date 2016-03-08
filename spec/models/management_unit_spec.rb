require 'rails_helper'

RSpec.describe ManagementUnit, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:management_unit)).to be_valid
  end
end
