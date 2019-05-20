
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tagliani/version"

Gem::Specification.new do |spec|
  spec.name          = "tagliani"
  spec.version       = Tagliani::VERSION
  spec.authors       = ["Aidan Rudkovskyi"]
  spec.email         = ["rrubyist@gmail.com"]

  spec.summary       = "Blazing fast Ruby library to create tags for Rails models"
  spec.description   = "Blazing fast Ruby alternative to acts-as-taggable-on and other similar gems. Instead of million of records in the database it uses powerful ElasticSearch, which gives a very fast and scalable solution with a search capabilities of ElasticSearch."
  spec.homepage      = "https://theoryofe.co/tagliani"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/rudkovskyi/tagliani/"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activerecord"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "elasticsearch"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "redis"  
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "pry"
end
