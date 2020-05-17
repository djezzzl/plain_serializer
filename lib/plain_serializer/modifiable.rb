# frozen_string_literal: true

module PlainSerializer
  # Module which adds support of modifying output
  module Modifiable
    def serialize(entity, &block)
      result = super(entity)

      return if result.nil?

      block&.call(result, entity)

      result
    end

    def serialize_collection(entities, &block)
      return if entities.nil?

      entities.each_with_object([]) do |entity, result|
        result << serialize(entity, &block)
      end
    end
  end
end
