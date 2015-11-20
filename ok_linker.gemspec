require File.expand_path("../lib/ok_linker/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "ok_linker"
  spec.version       = OkLinker::VERSION
  spec.authors       = ["Ilya Bodrov"]
  spec.email         = ["golosizpru@gmail.com"]
  spec.summary       = %q{Ruby gem for okey.link API.}
  spec.description   = %q{Ruby gem for Odnoklassniki's URL shortening service okey.link.}
  spec.homepage      = "https://github.com/bodrovis/ok_linker"
  spec.license       = "MIT"
  spec.platform      = Gem::Platform::RUBY

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday",            "~> 0.9"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "multi_json",         "~> 1.11"

  spec.add_development_dependency "rake",   "~> 10.4"
  spec.add_development_dependency "rspec",  "~> 3.4"
  spec.add_development_dependency "pry",    "0.10.3"
  spec.add_development_dependency "vcr",    "~> 3.0", ">= 3.0.0"
end