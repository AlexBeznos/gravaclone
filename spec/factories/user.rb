FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'qweqweqweqwe' }
  end
end
