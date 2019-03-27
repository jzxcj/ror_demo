FactoryBot.define do
  factory :rating do
    rate { Random.rand(1..5) }
    post
  end
end
