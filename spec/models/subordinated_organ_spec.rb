require 'rails_helper'

RSpec.describe SubordinatedOrgan, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:subordinated_organ)).to be_valid
  end
end
