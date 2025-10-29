source "https://rubygems.org"

# Rails framework
gem "rails", "~> 8.0.3"

# Asset pipeline
gem "propshaft"

# Database
gem "sqlite3", ">= 2.1"

# Web server
gem "puma", ">= 5.0"

# JavaScript and frontend
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# API building
gem "jbuilder"

# Platform specific
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Caching and background jobs
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Performance
gem "bootsnap", require: false

# Deployment
gem "kamal", require: false
gem "thruster", require: false

# Web scraping and testing
gem "nokogiri", "~> 1.18", ">= 1.18.10"
gem "cuprite", "~> 0.17"
gem "playwright-ruby-client", "~> 1.55"

# Application architecture
gem "interactor", "~> 3.2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "dotenv", "~> 3.1", ">= 3.1.8"
end

group :development do
  gem "web-console"
end

group :test do
  gem "selenium-webdriver"
  gem "rspec-rails", "~> 8.0", ">= 8.0.2"
  gem "factory_bot_rails", "~> 6.5", ">= 6.5.1"
end
