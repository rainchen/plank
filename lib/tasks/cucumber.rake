$LOAD_PATH.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib') if File.directory?(RAILS_ROOT + '/vendor/plugins/cucumber/lib')

begin
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format pretty"
  end
  task :features => 'db:test:prepare'
rescue LoadError
  desc 'Cucumber rake task not available'
  task :features do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end

namespace :cucumber do
  # Sets up the Rails environment for Cucumber
  ENV["RAILS_ENV"] = "test" # set env for db:seed
  desc "Prepare test database and seed data for cucumber"
  task :prepare => 'db:test:prepare'
  task :prepare => 'db:seed' if File.directory?("#{RAILS_ROOT}/db/fixtures")
  task :prepare do
    puts %q{It's ready for "cucumber features -n"}
  end
  ENV["RAILS_ENV"] = RAILS_ENV # restore env

end

