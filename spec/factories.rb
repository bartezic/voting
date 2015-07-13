FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name "Test User"
    sequence(:email) { |n| "email#{Time.now.to_i}#{n}@example.com" }
    password "please123"
  end

  factory :poll do
    question "MyString"
    token "MyString"
    multi false
    public false
    user
  end

  factory :option do
    poll
    name "MyString"
  end

  factory :answer do
    option
    user nil
    ip "1.1.1.1"
  end
end
