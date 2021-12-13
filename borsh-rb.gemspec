# frozen_string_literal: true

require_relative "lib/borsh/version"

Gem::Specification.new do |spec|
  spec.name          = "borsh-rb"
  spec.version       = Borsh::VERSION
  spec.authors       = ["Serg Tyatin"]
  spec.email         = ["700@2rba.com"]

  spec.summary       = "https://borsh.io implementation for ruby"
  spec.description   = ""
  spec.homepage      = "https://github.com/2rba/borsh-rb"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/2rba/borsh-rb"
  spec.metadata["changelog_uri"] = "https://github.com/2rba/borsh-rb"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "pry"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
