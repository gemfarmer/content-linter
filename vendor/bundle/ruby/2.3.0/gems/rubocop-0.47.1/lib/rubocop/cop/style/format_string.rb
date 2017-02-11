# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # This cop enforces the use of a single string formatting utility.
      # Valid options include Kernel#format, Kernel#sprintf and String#%.
      #
      # The detection of String#% cannot be implemented in a reliable
      # manner for all cases, so only two scenarios are considered -
      # if the first argument is a string literal and if the second
      # argument is an array literal.
      class FormatString < Cop
        include ConfigurableEnforcedStyle

        MSG = 'Favor `%s` over `%s`.'.freeze

        def_node_matcher :formatter, <<-PATTERN
        {
          (send nil ${:sprintf :format} _ _ ...)
          (send {str dstr} $:% ... )
          (send !nil $:% {array hash})
        }
        PATTERN

        def on_send(node)
          return unless (selector = formatter(node))

          detected_style = selector == :% ? :percent : selector
          return if detected_style == style

          add_offense(node, :selector, message(detected_style))
        end

        def message(detected_style)
          format(MSG, method_name(style), method_name(detected_style))
        end

        def method_name(style_name)
          style_name == :percent ? 'String#%' : style_name
        end
      end
    end
  end
end
