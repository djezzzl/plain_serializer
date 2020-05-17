# frozen_string_literal: true

require 'ostruct'
require 'plain_serializer'

user = OpenStruct.new(
  account: OpenStruct.new(name: 'USA'),
  properties: [
    OpenStruct.new(code: 'property1'),
    OpenStruct.new(code: 'property2')
  ]
)

class PropertySerializer < PlainSerializer::Base
  define_attribute :code
end

class AccountSerializer < PlainSerializer::Base
  define_attribute :name
end

class UserSerializer < PlainSerializer::Base
  define_serializer :account, AccountSerializer
  define_collection_serializer :properties, PropertySerializer
end

serializer = UserSerializer.setup(account: :name, properties: :code)
p serializer.serialize(user)
