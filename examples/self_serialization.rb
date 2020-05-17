# frozen_string_literal: true

require 'ostruct'
require 'plain_serializer'
require 'date'

user = OpenStruct.new(
  birthday: DateTime.now
)

class DateTimeSerializer < PlainSerializer::Base
  def serialize(entity)
    entity.iso8601
  end
end

class UserSerializer < PlainSerializer::Base
  define_serializer :birthday, DateTimeSerializer
end

serializer = UserSerializer.setup(:birthday)
p serializer.serialize(user)

p DateTimeSerializer.setup.serialize(DateTime.now)
