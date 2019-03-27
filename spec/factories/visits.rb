FactoryBot.define do
  factory :visit do
    ip     { Faker::Internet.ip_v4_address }
    logins { Array.new(10) { Faker::Internet.email } }
  end
end
