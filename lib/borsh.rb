# frozen_string_literal: true

require_relative 'borsh/version'
require_relative 'borsh/string'
require_relative 'borsh/integer'
require_relative 'borsh/byte_string'

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
    when :u8, :u16, :u32, :u64, :u128
      Integer.new(value, schema).to_borsh
    when ::Integer
      Borsh::ByteString.new(value, schema).to_borsh
    when ::Hash
      schema.map{ |entry_source, entry_schema| to_borsh_schema(value.send(entry_source), entry_schema) }.join
    when ::Array
      Integer.new(value.count, :u32).to_borsh + \
      value.flat_map do |item|
        schema.map{ |entry_schema| to_borsh_schema(item, entry_schema) }
      end.join
    when :borsh
      value.to_borsh
    else
      raise ArgumentError, "unknown serializer #{schema}, supported serializers: :string, :u8, :u16, :u32, :u64, :u128, :borsh"
    end
  end

  module ParentClassMethods
    def borsh(schema)
      @borsh_schema = schema
    end
  end
end
