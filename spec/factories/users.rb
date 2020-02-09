FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Superhero.name }
    designation { :mr }
    username { Faker::FunnyName.name }
  end
end
