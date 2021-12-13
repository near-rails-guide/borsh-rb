# frozen_string_literal: true

require_relative "version"
require_relative "string"
require_relative "integer"
require_relative "byte_string"

module Borsh
  def self.included(base)
    base.extend ParentClassMethods
  end

  def to_borsh
    to_borsh_schema(self, self.class.instance_variable_get(:@borsh_schema))
  end

  private

  def to_borsh_schema(value, schema)
    case schema
    when :string
      String.new(value).to_borsh
    when :u8, :u16, :u32, :u64
      Integer.new(value, schema).to_borsh
    when ::Integer
      Borsh::ByteString.new(value, schema).to_borsh
    when ::Hash
      schema.map{ |entry_source, entry_schema| to_borsh_schema(value.public_send(entry_source), entry_schema) }.join
    when ::Array
      schema.map{ |entry_schema| to_borsh_schema(value, entry_schema) }.join
    when :borsh
      value.to_borsh
    else
      raise ArgumentError, "unknown serializer #{schema}, supported serializers: :string, :u8, :u16, :u32, :u64, :borsh"
    end
  end

  module ParentClassMethods
    def borsh(schema)
      @borsh_schema = schema
    end
  end
end
