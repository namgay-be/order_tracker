FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Superhero.name }
    designation { :mr }
    username { Faker::FunnyName.name }

    after(:build) do |user|
      user.skip_confirmation!
    end
  end
end
