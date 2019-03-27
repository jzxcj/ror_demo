FactoryBot.define do
  factory :user do
    login { Faker::Internet.email }
  end
end
