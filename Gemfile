source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Twitter bootstrap
gem 'bootstrap-sass'
# Highcharts
gem 'lazy_high_charts', :git => 'git://github.com/lamoglia/lazy_high_charts.git'

gem 'rails-i18n'

gem 'will_paginate'
gem 'will_paginate-bootstrap'
# Formatação
gem 'cpf_cnpj'

gem 'groupdate'

gem 'meta-tags', :git => 'git://github.com/lamoglia/meta-tags.git', :branch => 'iss_102'

gem 'actionpack-page_caching'

gem 'actionpack-action_caching'

gem 'rake', '11.1.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :test do
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  # Code coverage
  gem 'simplecov', :require => false
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rack-mini-profiler'
end

group :development, :production do
  gem 'mysql2', '~> 0.3.20'
end

group :production do
  gem 'puma'
end
