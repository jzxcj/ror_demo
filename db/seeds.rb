require 'faker'

Rails.configuration.cache_classes = true
Rails.configuration.allow_concurrency = true
Rails.application.eager_load!

ips = Array.new(50) { Faker::Internet.unique.ip_v4_address }
logins = Array.new(100) { Faker::Internet.unique.email }

posts   = []
threads = []

pp 'Generating posts...'
50.times do
  threads << Thread.new do
    2500.times do
      creating = CreatePost.(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, login: logins.sample, ip: ips.sample)
      posts << creating.result
    end
    ActiveRecord::Base.connection_pool.release_connection
  end
end

threads.each(&:join)
threads.clear

pp 'Generating rates...'
50.times do
  threads << Thread.new do
    100.times do
      UpdateRating.(posts.sample, Random.rand(1..5))
    end
    ActiveRecord::Base.connection_pool.release_connection
  end
end

threads.each(&:join)

ActiveRecord::Base.connection.execute('VACUUM ANALYZE;')
