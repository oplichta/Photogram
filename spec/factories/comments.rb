FactoryGirl.define do
  factory :comment do
    user
    post
    content 'Nice post!'
  end
end
