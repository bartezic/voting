describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it 'has a valid factory' do
    expect(create(:user)).to be_valid
    expect(build(:user)).to be_valid
  end

  it 'invalid without email' do
    expect(build(:user, email: nil)).to_not be_valid
  end

  it 'invalid with wrong email' do
    expect(build(:user, email: 'em@ail')).to_not be_valid
    expect(build(:user, email: 'test@mail.com')).to be_valid
  end

end
