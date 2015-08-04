FactoryGirl.define do
  sequence(:user_name) { |i| "user#{i}" }
  sequence(:email) { |i| "example#{i}@email.com" }

  factory :user do
    user_name
    email
    password 'password'
    password_confirmation 'password'
  end
end
