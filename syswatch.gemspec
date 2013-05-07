# -*- encoding: utf-8 -*-
require File.expand_path('../lib/syswatch/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Łukasz Jachymczyk"]
  gem.email = ["lukasz.jachymczyk@sology.pl"]
  gem.description = %q{Simple system monitoring tool with e-mail alerting.}
  gem.summary = %q{Simple system monitoring tool with e-mail alerting.}
  gem.homepage = "https://github.com/Sology/syswatch"

  gem.name = "syswatch"
	gem.license      = "MIT"
  gem.version = SysWatch::VERSION
	gem.required_ruby_version = '>= 1.9'

  gem.files = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'sys-filesystem'
  gem.add_dependency 'pony'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.10'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'mailcatcher'
end
