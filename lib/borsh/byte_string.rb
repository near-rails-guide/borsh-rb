class Borsh::ByteString
  def initialize(value, length)
    @value = value
    @length = length
  end

  def to_borsh
    raise Borsh::ArgumentError, 'ByteString length mismatch' if value.size != length

    value
  end

  private

  attr_reader :value, :length
end
