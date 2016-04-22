lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bulwark/version'

Gem::Specification.new do |gem|
  gem.name                  = 'bulwark'
  gem.version               = Bulwark::VERSION
  gem.authors               = ['Joshua Plicque']
  gem.summary               = 'Mass update your S3 file permissions.'
  gem.email                 = 'plicjo@gmail.com'
  gem.homepage              = 'https://github.com/plicjo/bulwark'
  gem.license               = 'MIT'

  gem.files                 = `git ls-files`.split($/)
  gem.require_paths         = ['lib']
  gem.required_ruby_version = '>= 2.0.0'
  gem.bindir                = 'bin'
  gem.executables           = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files            = gem.files.grep(%r{^(spec)/}) { |f| File.basename(f) }

  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake'   , '~> 10.0'
  gem.add_development_dependency 'rspec'  , '~> 3.4'
  gem.add_development_dependency 'pry'    , '~> 0.10.3'
  gem.add_dependency 'dotenv'             , '~> 2.1'    , '>= 2.1.1'
  gem.add_dependency 'aws-sdk', '~> 2'
end
