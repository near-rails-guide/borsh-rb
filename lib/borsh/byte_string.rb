class Borsh::ByteString
  def initialize(value, length)
    @value = value
    @length = length
  end

  def to_borsh
    raise ArgumentError, 'ByteString length mismatch' if value.size * 8 != length

    value
  end

  private

  attr_reader :value, :length
end
