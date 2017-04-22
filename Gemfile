source 'https://rubygems.org'

ruby '2.3.3'
gem 'rails', '4.2.4'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'devise'

group :test do
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
  gem 'capybara'
  gem 'simplecov', :require => false
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~>3.3', '>= 3.3.3'
  gem 'sqlite3'
  gem 'rspec', '~> 3.3.0'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '~> 2.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

