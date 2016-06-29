source 'https://rubygems.org'

gem 'rails', '4.2.5.1'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'devise'
gem 'activeadmin', github: 'activeadmin'
gem 'cancancan', '~> 1.10'
gem 'devise_token_auth',
    github: 'osulyanov/devise_token_auth'
# path: '../devise_token_auth'
gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem 'apipie-rails', github: 'Apipie/apipie-rails'
gem 'maruku'
gem 'rack-cors', require: 'rack/cors'

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
  gem 'rollbar'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'letter_opener'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :development, :test do
  gem 'byebug'
  gem 'annotate', github: 'ctran/annotate_models'
end

group :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
end
