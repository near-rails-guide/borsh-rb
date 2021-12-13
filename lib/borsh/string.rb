class Borsh::String
  def initialize(value)
    @value = value
  end

  def to_borsh
    length = [value.length].pack('V')
    raise ArgumentError, 'string too long' if length.unpack('V') != [value.length]

    length + value
  end

  private

  attr_reader :value
end
