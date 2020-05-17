# frozen_string_literal: true

module PlainSerializer
  # The base class
  class Base
    prepend Modifiable

    include Serializable
    include Configurable

    def initialize(*args)
      Helpers.extract_options!(args)

      @attributes = args
    end

    def serialize(entity)
      return if entity.nil?

      @attributes.each_with_object({}) do |attribute, result|
        result[attribute] = send(attribute, entity)
      end
    end

    def serialize_collection(entities)
      return if entities.nil?

      entities.each_with_object([]) do |entity, result|
        result << serialize(entity)
      end
    end

    class << self
      private

      def define_attribute(name)
        define_method(name) do |entity|
          entity.send(name)
        end
      end
    end
  end
end
