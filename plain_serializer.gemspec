# frozen_string_literal: true

require_relative 'lib/plain_serializer/version'

Gem::Specification.new do |spec|
  spec.name          = 'plain_serializer'
  spec.version       = PlainSerializer::VERSION
  spec.authors       = ['djezzzl']
  spec.email         = ['lawliet.djez@gmail.com']

  spec.summary       = 'Plain Serializer DSL'
  spec.homepage      = 'https://github.com/djezzzl/plain_serializer'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = 'https://github.com/djezzzl/plain_serializer'
  spec.metadata['source_code_uri'] = 'https://github.com/djezzzl/plain_serializer'
  spec.metadata['changelog_uri'] = 'https://github.com/djezzzl/plain_serializer/CHANGELOG.md'

  spec.files         = Dir['lib/**/*']
  spec.require_paths = ['lib']
end
