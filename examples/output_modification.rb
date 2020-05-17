# frozen_string_literal: true

require 'ostruct'
require 'plain_serializer'

user = OpenStruct.new(name: 'John Doe')

class UserSerializer < PlainSerializer::Base
  define_attribute :name
end

serializer = UserSerializer.setup(:name)

p(serializer.serialize(user) do |output|
  output[:anything] = 'anything_you_want_here'
end)
