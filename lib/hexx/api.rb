# encoding: utf-8

module Hexx

  # Features to convert a module to API
  #
  # @example
  #   module MyModule
  #     extend Hexx::API
  #
  #     api_method :foo, Foo
  #     api_method :bar, Bar, :build
  #   end
  #
  #   MyModule[:foo]      # => Foo
  #   MyModule.foo(*args) # => Foo.new(*args)
  #
  #   MyModule[:bar]      # => Bar
  #   MyModule.bar(*args) # => Bar.build(*args)
  module API

    # Returns the constant defined by API
    #
    # @param [#to_sym] name
    #
    # @return [Object]
    def [](name)
      __api__[name.to_sym]
    end

    # Defines the named method of API
    #
    # @param [#to_sym] name The name of the API method
    # @param [Object] type The type of the object to be returned by #{[]}
    # @param [String, Symbol] method
    #   The name of the type method, that should be called by API name
    #
    # @return [self] itself
    def api_method(name, type, method = :new)
      __api__[name.to_sym] = type
      singleton_class.__send__(:define_method, name) do |*args|
        type.public_send method, *args
      end

      self
    end

    private

    attr_reader :__api__

    def __api__
      @__api__ ||= {}
    end

  end # module API

end # module Hexx
