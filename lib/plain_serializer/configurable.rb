# frozen_string_literal: true

module PlainSerializer
  # Module which adds support of groups
  module Configurable
    def self.included(base)
      base.extend ClassMethods
    end

    # Defines required methods for base class
    module ClassMethods
      def setup(*args)
        opts = Helpers.extract_options!(args)

        attributes = args.each_with_object([]) do |attribute, result|
          next result << attribute unless group?(attribute)

          group(attribute).each do |group_attribute|
            if group_attribute.is_a?(Hash)
              opts.merge!(group_attribute)
            else
              result << group_attribute
            end
          end
        end

        super(*attributes, **opts)
      end

      private

      def define_group(name, attributes)
        groups[name] = attributes
      end

      def groups
        @groups ||= {}
      end

      def group(name)
        groups[name]
      end

      def group?(name)
        groups.key?(name)
      end
    end
  end
end
