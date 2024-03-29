require_relative 'lib/simple_method_callback/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_method_callback"
  spec.version       = SimpleMethodCallback::VERSION
  spec.authors       = ["sumingxuan"]
  spec.email         = ["1154621382@qq.com"]

  spec.summary       = %q{nil}
  spec.description   = %q{简单的在class添加回调，比如在service、model中}
  spec.homepage      = "https://github.com/SuMingXuan/simple_method_callback"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
