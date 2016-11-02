# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chatwork_to_slack/version'

Gem::Specification.new do |spec|
  spec.name          = "chatwork_to_slack"
  spec.version       = ChatWorkToSlack::VERSION
  spec.authors       = ["kkosuge"]
  spec.email         = ["root@kksg.net"]

  spec.summary       = %q{export ChatWork(chatwork.com) logs to Slack CSV format}
  spec.description   = %q{export ChatWork(chatwork.com) logs to Slack CSV format}
  spec.homepage      = "https://github.com/kkosuge/chatwork_to_slack"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "chatwork", "~> 0.3"
  spec.add_runtime_dependency "goodbye_chatwork", "~> 0.0"
end
