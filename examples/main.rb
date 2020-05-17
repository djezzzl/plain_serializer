# frozen_string_literal: true

require 'ostruct'
require 'plain_serializer'

user = OpenStruct.new(
  name: 'John Doe',
  age: 30
)

class UserSerializer < PlainSerializer::Base
  define_attribute :name
  define_attribute :age
end

serializer = UserSerializer.setup(:name, :age)
p serializer.serialize(user)

p serializer.serialize_collection([user])
