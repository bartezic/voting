require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'has a valid factory' do
    expect(create(:answer)).to be_valid
    expect(build(:answer)).to be_valid
  end

  it 'invalid without a option' do
    expect(build(:answer, option_id: nil)).to_not be_valid
  end

  it 'invalid without a ip' do
    expect(build(:answer, ip: nil)).to_not be_valid
  end
end
