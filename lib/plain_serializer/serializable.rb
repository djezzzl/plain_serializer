# frozen_string_literal: true

module PlainSerializer
  # Module which adds support of nested serializers
  module Serializable
    def self.included(base)
      base.extend ClassMethods
    end

    def setup_serializer(name, attributes)
      serializers[name] = self.class.serializers[name].setup(*attributes)
    end

    def serializers
      @serializers ||= {}
    end

    def serializer(name)
      serializers[name] || self.class.serializers[name].new
    end

    # Defines required methods for base class
    module ClassMethods
      def setup(*args)
        options = Helpers.extract_options!(args)

        attributes = args + options.keys

        new(*attributes).tap do |instance|
          options.each do |serializer_name, opts|
            instance.setup_serializer(serializer_name, opts)
          end
        end
      end

      def define_serializer(name, klass)
        serializers[name] = klass

        define_method(name) do |entity|
          serializer(name).serialize(entity.send(name))
        end
      end

      def define_collection_serializer(name, klass)
        serializers[name] = klass

        define_method(name) do |entity|
          serializer(name).serialize_collection(entity.send(name))
        end
      end

      def serializers
        @serializers ||= {}
      end
    end
  end
end
