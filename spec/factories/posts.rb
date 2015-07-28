FactoryGirl.define do
  factory :post do
    caption 'nofilter'
    image Rack::Test::UploadedFile.new(Rails.root +
    'spec/fixtures/images/coffee.png', 'image/png')
    user
  end
end
