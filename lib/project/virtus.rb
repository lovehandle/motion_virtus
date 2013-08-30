motion_require 'stubs.rb'
motion_require 'support/equalizer'
motion_require 'support/type_lookup'
motion_require 'support/options'

module Virtus

  # Provides args for const_get and const_defined? to make them behave
  # consistently across different versions of ruby
  EXTRA_CONST_ARGS = (RUBY_VERSION < '1.9' ? [] : [ false ]).freeze

  #Undefined = Object.new.freeze

  # Extends base class or a module with virtus methods
  #
  # @param [Object] object
  #
  # @return [undefined]
  #
  # @api private
  def self.included(object)
    super
    if object.class.name == "Class"
      object.send(:include, ClassInclusions)
    else
      object.extend(ModuleExtensions)
    end
  end
  private_class_method :included

  # Extends an object with virtus extensions
  #
  # @param [Object] object
  #
  # @return [undefined]
  #
  # @api private
  def self.extended(object)
    object.extend(Extensions)
  end
  private_class_method :extended

  # Sets the global coercer configuration
  #
  # @example
  #   Virtus.coercer do |config|
  #     config.string.boolean_map = { true => '1', false => '0' }
  #   end
  #
  # @return [Coercible::Coercer]
  #
  # @api public
  def self.coercer(&block)
    configuration.coercer(&block)
  end

  # Sets the global coercion configuration value
  #
  # @param [Boolean] value
  #
  # @return [Virtus]
  #
  # @api public
  def self.coerce=(value)
    configuration.coerce = value
    self
  end

  # Returns the global coercion setting
  #
  # @return [Boolean]
  #
  # @api public
  def self.coerce
    configuration.coerce
  end

  # Provides access to the global Virtus configuration
  #
  # @example
  #   Virtus.config do |config|
  #     config.coerce = false
  #   end
  #
  # @return [Configuration]
  #
  # @api public
  def self.config(&block)
    configuration.call(&block)
  end

  # Provides access to the Virtus module builder
  # see Virtus::ModuleBuilder
  #
  # @example
  #   MyVirtusModule = Virtus.module { |mod|
  #     mod.coerce = true
  #     mod.string.boolean_map = { 'yup' => true, 'nope' => false }
  #   }
  #
  #  class Book
  #    include MyVirtusModule
  #
  #    attribute :published, Boolean
  #  end
  #
  #  # This could be made more succinct as well
  #  class OtherBook
  #    include Virtus.module { |m| m.coerce = false }
  #  end
  #
  # @return [Module]
  #
  # @api public
  def self.module(&block)
    ModuleBuilder.call(&block)
  end

  # Global configuration instance
  #
  # @ return [Configuration]
  #
  # @api private
  def self.configuration
    @configuration ||= Configuration.new
  end

end
