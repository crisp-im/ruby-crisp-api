require File.expand_path("../lib/crisp-api", __FILE__)

Gem::Specification.new do |s|
  s.name          = 'crisp-api'
  s.version       = '1.0.4'
  s.date          = Date.today
  s.summary       = "Crisp API Ruby"
  s.description   = "Crisp API Ruby"
  s.authors       = ["Valerian Saliou"]
  s.email         = 'valerian@valeriansaliou.name'
  s.files         = `git ls-files`.split($/)
  s.homepage      = 'https://github.com/crisp-im/ruby-crisp-api'
  s.license       = 'MIT'
  s.require_paths = ['lib']

  s.add_dependency 'rest-client', '~> 2.0.0'
end
