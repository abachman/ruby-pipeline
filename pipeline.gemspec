# frozen_string_literal: true

require_relative "lib/pipeline/version"

Gem::Specification.new do |spec|
  spec.name = "pipeline"
  spec.version = Pipeline::VERSION
  spec.authors = ["Adam Bachman"]
  spec.email = ["adam.bachman@gmail.com"]

  spec.summary = "A DSL for creating staged processing pipelines."
  spec.homepage = "https://github.com/abachman/pipeline"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/abachman/pipeline"
  spec.metadata["changelog_uri"] = "https://github.com/abachman/pipeline"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "concurrent-ruby", "~> 1.2", ">= 1.2.3"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
