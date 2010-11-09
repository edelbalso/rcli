require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rcli"
    gem.summary = %Q{A rough framework for building command-line scripts in ruby.}
    gem.description = %Q{This script creates, manages, installs, uninstalls and edits command-line ruby scripts. It also works as a useful library for building scripts.}
    gem.email = "e.delbalso@gmail.com"
    gem.homepage = "http://github.com/edelbalso/rcli"
    gem.authors = ["Eduardo Del Balso"]
    
    gem.add_dependency "text", ">= 0.2.0"
    gem.add_dependency "highline", ">= 1.6.1"
    #gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings

    gem.executables = ['rcli']
    gem.require_paths = ['lib']

    gem.files = FileList['lib/config/*','lib/**/*.rb','README*', 'LICENSE', 'Rakefile', 'test/**/*.*', 'bin/**/*.rb'].to_a
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rcli-gem #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
