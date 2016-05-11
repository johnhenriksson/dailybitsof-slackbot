require 'rubygems'
require 'bundler'

Bundler.setup :default, :development

unless ENV['RACK_ENV'] == 'production'

  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = FileList['spec/**/*_spec.rb']
  end

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  task default: [:rubocop, :spec]

  import 'tasks/db.rake'
end

namespace :dailybitsof do

	require './slack-bot-server'

	desc "Delivers daily lessons"
	task :daily_lesson do
		Dailybitsof.daily_lesson
	end

end

