# frozen_string_literal: true

require 'ostruct'
require 'plain_serializer'

user = OpenStruct.new(
  name: 'John Doe',
  age: '30',
  account: OpenStruct.new(name: 'USA')
)

class AccountSerializer < PlainSerializer::Base
  define_attribute :name
end

class UserSerializer < PlainSerializer::Base
  define_attribute :name
  define_attribute :age

  define_group :personal, [:age, account: :name]

  define_serializer :account, AccountSerializer
end

serializer = UserSerializer.setup(:name, :personal)
p serializer.serialize(user)
