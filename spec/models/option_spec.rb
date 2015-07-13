require 'rails_helper'

RSpec.describe Option, type: :model do
  it 'has a valid factory' do
    expect(create(:option)).to be_valid
    expect(build(:option)).to be_valid
  end

  it 'invalid without a name' do
    expect(build(:option, name: nil)).to_not be_valid
  end
end
