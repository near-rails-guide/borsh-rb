# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Borsh::String do
  subject(:serialized) { described_class.new(string).to_borsh }

  let(:string) { 'test' }

  it 'serializes string' do
    expect(serialized).to eq([4, 0, 0, 0].map(&:chr).join + 'test')
  end
end
