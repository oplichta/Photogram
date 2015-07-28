require 'ffaker'

FactoryGirl.define do
  factory :user do
    user_name { FFaker::Internet.user_name }
    email { FFaker::Internet.email }
    password 'password'
    password_confirmation 'password'
  end
end
