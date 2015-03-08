source 'https://rubygems.org'

ruby "2.1.2"

gem 'rails', '4.1.0'
gem 'rails-api'

gem "mysql2", ">= 0.3.11"
gem "libv8", ">= 3.11.8"
gem "devise", ">= 2.2.3"
gem "cancan", ">= 1.6.9"
gem "rolify", ">= 3.2.0"
gem "figaro", ">= 0.6.3"
gem 'factory_girl_rails', :require => false #don't require because of http://goo.gl/kgnKz
gem "active_model_serializers", "~> 0.9.0"
gem 'simple_token_authentication'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem "therubyracer", ">= 0.11.3", :platform => :ruby, :require => "v8"

group :development do
  gem "rails-erd"
  gem "quiet_assets", ">= 1.0.2"
  gem "better_errors", ">= 0.7.2"
  gem "binding_of_caller", ">= 0.7.1", :platforms => [:mri_19, :rbx]
end

group :development, :test do
  gem 'spring-commands-rspec' 
  gem "rspec-rails", "~> 3.0.0.beta"
end

group :test do
  gem 'shoulda-matchers', "~> 2.6.0", require: false
end

group :production do
  gem "thin", ">= 1.5.0"
end