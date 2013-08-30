motion_require 'object'

module Virtus
  class Attribute

    # Base class for all numerical attributes
    class Numeric < Object
      primitive      ::Numeric
      #accept_options :min, :max

      def self.min(value=Undefined)
        return @min if value.equal?(Undefined)
        @min = value
        self
      end

      def self.max(value=Undefined)
        return @max if value.equal?(Undefined)
        @max = value
        self
      end

    end # class Numeric
  end # class Attribute
end # module Virtus
