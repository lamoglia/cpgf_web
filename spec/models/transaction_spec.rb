require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:transaction)).to be_valid
  end
end

describe Transaction do
  it { is_expected.to validate_presence_of(:superior_organ) }
  it { is_expected.to validate_presence_of(:subordinated_organ) }
  it { is_expected.to validate_presence_of(:management_unit) }
  it { is_expected.to validate_presence_of(:source) }
  it { is_expected.to validate_presence_of(:person) }
  it { is_expected.to validate_presence_of(:favored) }
  it { is_expected.to validate_presence_of(:transaction_type) }
end     