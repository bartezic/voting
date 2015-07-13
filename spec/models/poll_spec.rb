require 'rails_helper'

RSpec.describe Poll, type: :model do
  it 'has a valid factory' do
    expect(create(:poll)).to be_valid
    expect(build(:poll)).to be_valid
  end

  it 'invalid without a question' do
    expect(build(:poll, question: nil)).to_not be_valid
  end

  it 'invalid with wrong email' do
    expect(build(:user, email: 'em@ail')).to_not be_valid
    expect(build(:user, email: 'test@mail.com')).to be_valid
  end
end
