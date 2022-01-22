# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Borsh::ByteString do
  subject(:serialized) { described_class.new(value, 4).to_borsh }

  let(:value) { 'test' }

  it 'serializes string' do
    expect(serialized).to eq('test')
  end
end
