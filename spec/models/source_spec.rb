require 'rails_helper'

RSpec.describe Source, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:source)).to be_valid
  end
end

describe Source do
  it { is_expected.to validate_presence_of(:file_name) }
  it { should validate_uniqueness_of(:file_name).case_insensitive }
  it { is_expected.to validate_presence_of(:reference) }
  it { should validate_uniqueness_of(:reference) }
  it { is_expected.to validate_presence_of(:imported_at) }
end