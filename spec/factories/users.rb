FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Superhero.name }
    designation { :mr }
    phone { '17617569' }
    username { Faker::FunnyName.name }
  end
end
