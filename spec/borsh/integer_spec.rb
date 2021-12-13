# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Borsh::Integer do
  subject(:serialized) { described_class.new(string).to_borsh }

  let(:value) { 128 }

  it 'serializes :u8' do
    expect(described_class.new(value, :u8).to_borsh).to eq([128].map(&:chr).join)
  end

  it 'serializes :u16' do
    expect(described_class.new(value, :u16).to_borsh).to eq([128, 0].map(&:chr).join)
  end

  it 'serializes :u32' do
    expect(described_class.new(value, :u32).to_borsh).to eq([128, 0, 0, 0].map(&:chr).join)
  end

  it 'serializes :u64' do
    expect(described_class.new(value, :u64).to_borsh).to eq([128, 0, 0, 0, 0, 0, 0, 0].map(&:chr).join)
  end
end
