# frozen_string_literal: true

require_relative "lib/lottery_strategy/version"

Gem::Specification.new do |spec|
  spec.name          = "lottery_strategy"
  spec.version       = LotteryStrategy::VERSION
  spec.authors       = ["Artur"]
  spec.email         = ["info@aigroupusa.com"]

  spec.summary       = "ghgj"
  spec.description   = "ghggh"
  spec.homepage      = "https://github.com/art-0007/lottery_strategy"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://github.com/art-0007/lottery_strategy"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/art-0007/lottery_strategy"
  spec.metadata["changelog_uri"] = "https://github.com/art-0007/lottery_strategy"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiry"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
