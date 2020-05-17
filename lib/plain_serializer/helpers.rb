# frozen_string_literal: true

module PlainSerializer
  # The module which provides helpers
  module Helpers
    module_function

    def extract_options!(array)
      array.last.is_a?(Hash) ? array.pop : {}
    end
  end
end
