FactoryGirl.define do
  factory :client_application do
    name { Faker::Company.name }
    redirect_uri { 'urn:ietf:wg:oauth:2.0:oob' }
    association :owner, factory: :user
  end
end
