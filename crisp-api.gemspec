require "date"

Gem::Specification.new do |s|
  s.name          = "crisp-api"
  s.version       = "1.1.16"
  s.date          = Date.today
  s.summary       = "Crisp API Ruby"
  s.description   = "Crisp API Ruby"
  s.authors       = ["Valerian Saliou"]
  s.email         = "valerian@valeriansaliou.name"
  s.files         = `git ls-files`.split($/)
  s.homepage      = "https://github.com/crisp-im/ruby-crisp-api"
  s.license       = "MIT"
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.7"

  s.add_dependency "faraday", "~> 2.0"
end
