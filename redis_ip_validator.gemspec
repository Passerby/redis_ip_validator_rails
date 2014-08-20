$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'redis_ip_validator/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'redis_ip_validator_rails'
  s.version     = RedisIpValidator::VERSION
  s.authors     = ['Mr.Passer-by']
  s.email       = ['dr397379567@gmail.com']
  s.homepage    = 'luke-du.com'
  s.summary     = 'record ip'
  s.description = 'record ip'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 4.0.0'
  s.add_dependency 'redis', '>= 2.2'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundle'
  s.add_development_dependency 'git'
end
