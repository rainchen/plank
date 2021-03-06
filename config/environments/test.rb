# Settings specified here will take precedence over those in config/environment.rb

# The test environment is used exclusively to run your application's
# test suite.  You never need to work with it otherwise.  Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs.  Don't rely on the data there!
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false
config.action_view.cache_template_loading            = true

# Disable request forgery protection in test environment
config.action_controller.allow_forgery_protection    = false

# Tell Action Mailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.delivery_method = :test

# Use SQL instead of Active Record's schema dumper when creating the test database.
# This is necessary if your schema can't be completely dumped by the schema dumper,
# like if you have constraints or database-specific column types
# config.active_record.schema_format = :sql

# Specify gems that this application depends on and have them installed with rake gems:install RAILS_ENV=test
config.gem 'nokogiri', :version => '1.2.3', :lib => false # required by webrat
config.gem 'webrat', :version => '0.4.4', :lib => false
config.gem 'cucumber', :version => '0.3.2', :lib => false # depends on builder, diff-lcs, polyglot, term-ansicolor, treetop.
config.gem 'thoughtbot-shoulda', :lib => 'shoulda', :source => 'http://gems.github.com', :version => '2.10.1'
config.gem 'mocha', :version => '0.9.5'
config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com', :version => '1.2.1'
config.gem "jnunemaker-matchy", :lib =>"matchy", :source => "http://gems.github.com/" #RSpec-esque matchers for Test::Unit  , required by basiszwo-email_spec
config.gem "basiszwo-email_spec", :lib => "email_spec", :source => "http://gems.github.com/"

# The constant is used by mailers to generate URLs in emails.
HOST = "www.example.com"

# enable debugger when RAILS_ENV=test
require 'ruby-debug'

