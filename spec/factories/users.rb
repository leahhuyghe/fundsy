FactoryGirl.define do
  factory :user do
      first_name  Faker::Name.first_name
      last_name   Faker::Name.last_name
      email       Faker::Internet.email
      sequence(:email)  {|n| "#{n}-#{Faker::Internet.email}"}
      password    "abc123"

  end
end