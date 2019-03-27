FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraph }
    ip    { Faker::Internet.ip_v4_address }
    user

    factory :post_with_rating do
      transient do
        ratings_count { 5 }
      end

      after(:create) do |post, tran|
        create_list(:rating, tran.ratings_count, post: post)
        post.update_avg_rating
      end
    end

    after(:create) do |post|
      visit = Visit.find_or_create_by(ip: post.ip) do |v|
        v.logins = [post.user.login]
      end

      visit.add_login(post.user.login)
    end
  end
end
