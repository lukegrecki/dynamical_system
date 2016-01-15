# encoding: utf-8

require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "dynamical_system"
  gem.homepage = "http://github.com/lukegrecki/dynamical_system"
  gem.license = "MIT"
  gem.summary = "A simple ruby library for discrete dynamical systems"
  gem.description = "Define simple dynamical systems, evolve them, and calculate properties."
  gem.email = "lukegrecki@gmail.com"
  gem.authors = ["Luke Grecki"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test
