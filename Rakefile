require 'rubygems'
require 'rake/testtask'
require 'rake/gempackagetask'
begin
  require 'lib/rfeedparser'
rescue LoadError
  module FeedParser; VERSION = '0.0.0'; end
  puts "Problem loading rfeedparser; try rake setup"
end

spec = Gem::Specification.new do |s|
  s.name       = "rfeedparser"
  s.version    = FeedParser::VERSION
  s.author     = "Jeff Hodges"
  s.email      = "jeff at somethingsimilar dot com"
  s.homepage   = "http://rfeedparser.rubyforge.org/"
  s.platform   = Gem::Platform::RUBY
  s.summary    = "Parse RSS and Atom feeds in Ruby"
  s.files      = FileList["{lib,tests}/**/*"].exclude("rdoc").to_a
  s.require_path      = "lib"
  # s.autorequire       = "feedparser" # tHe 3vil according to Why.
  s.has_rdoc          = false # TODO: fix
  s.extra_rdoc_files  = ['README','LICENSE', 'RUBY-TESTING']
  s.rubyforge_project = 'rfeedparser'

  # Dependencies
  s.add_dependency('rchardet', '>=1.1')
  s.add_dependency('nokogiri', '~>1.2')
  s.add_dependency('character-encodings', '>= 0.2.0')
  s.add_dependency('htmltools', '>= 1.10')
  s.add_dependency('htmlentities', '>=4.0.0')
  s.add_dependency('mongrel', '>=1.0.2')
  s.add_dependency('addressable', '>= 1.0.4')
end

Rake::GemPackageTask.new(spec) do

end

Rake::TestTask.new do |t|
  t.test_files = FileList['tests/rfeedparser_test.rb']
  t.verbose = true
end

task :default => [:test]

# Taken liberally from http://blog.labnotes.org/2008/02/28/svn-checkout-rake-setup/
desc "If you're building from source, run this task first to setup the necessary dependencies."
task :setup do

  puts "Checking for gems that need to be installed."
  gems = Gem::SourceIndex.from_installed_gems
  
  # Runtime dependencies from the Gem's spec
  dependencies = spec.dependencies
  
  dependencies.each do |dep|
    if gems.search(dep.name, dep.version_requirements).empty?
      puts "Installing dependency: #{dep}"
      begin
        require 'rubygems/dependency_installer'
        di = Gem::DependencyInstaller.new()
        di.install dep.name, dep.version_requirements
      rescue LoadError # < rubygems 1.0.1
        require 'rubygems/remote_installer'
        Gem::RemoteInstaller.new.install(dep.name, dep.version_requirements)
      end
    end
  end
  
  puts "\nAnd done."
end
