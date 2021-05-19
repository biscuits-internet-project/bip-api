source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.0'
gem 'pg'
gem 'puma', '~> 4.3'
gem 'rack-cors'
gem 'friendly_id'
gem 'simple_command'
gem 'stamp'
gem 'blueprinter'
gem 'jwt'
gem 'bcrypt', '~> 3.1.7'
gem 'rolify'
gem 'honeybadger', '~> 4.0'
gem 'aws-sdk-s3'
gem 'dalli'
gem 'httparty'
gem 'audited'
gem 'acts-as-taggable-on'
gem 'awesome_print'
gem 'mini_magick'
gem 'image_processing'
gem 'pg_search'
gem 'redis'
gem 'hiredis'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'solargraph'
  gem 'bullet'
end
