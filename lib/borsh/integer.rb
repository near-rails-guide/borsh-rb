class Borsh::Integer
  def initialize(value, type)
    @value = value
    @type = type
  end

  def to_borsh
    pack_arg = case type
               when :u8
                 'C'
               when :u16
                 'S<'
               when :u32
                 'L<'
               when :u64
                'Q<'
               else
                 raise ArgumentError, "unknown type #{type}"
               end

    result = [value].pack(pack_arg)
    raise ArgumentError, 'Integer serialization failure' if result.unpack(pack_arg) != [value]

    result
  end

  private

  attr_reader :value, :type
end
