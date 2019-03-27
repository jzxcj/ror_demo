source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'draper'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.2', '>= 5.2.2.1'
gem 'simple_command'

group :development, :test do
  gem 'byebug', platforms: [:mri]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  gem 'rubocop', require: false
  gem 'spring-commands-rspec'
end

group :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'rspec-json_expectations'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
