# frozen_string_literal: true

RSpec.describe Borsh do
  subject(:klass) do
    Class.new do
      include Borsh

      borsh username: :string

      def username
        'test'
      end
    end
  end

  it 'serializes string' do
    expect(klass.new.to_borsh).to eq([4, 0, 0, 0].map(&:chr).join + 'test')
  end

  context 'with integer' do
    subject(:klass) do
      Class.new do
        include Borsh

        borsh id: :u8

        def id
          128
        end
      end
    end

    it 'serializes string' do
      expect(klass.new.to_borsh).to eq([128].map(&:chr).join)
    end
  end

  context 'with borsh type' do
    subject(:klass) do
      Class.new do
        include Borsh

        borsh key: :borsh

        def key
          OpenStruct.new(to_borsh: [0x64].map(&:chr).join)
        end
      end
    end

    it 'delegates serialisation' do
      expect(klass.new.to_borsh).to eq([0x64].map(&:chr).join)
    end
  end

  context 'with preserialized value' do
    subject(:klass) do
      Class.new do
        include Borsh

        borsh key: 4

        def key
          'test'
        end
      end
    end

    it 'returns serialized result' do
      expect(klass.new.to_borsh).to eq('test')
    end
  end

  context 'with nested serialsation' do
    subject(:object) { klass.new(signer_id, key) }
    subject(:klass) do
      Class.new do
        include Borsh

        attr_reader :signer_id, :key

        def initialize(signer_id, key)
          @signer_id = signer_id
          @key = key
        end

        borsh signer_id: :string,
              key: { key_type: :u8, public_key: 32 }
      end
    end

    let(:signer_id) { '1234' }
    let(:key) { OpenStruct.new(key_type: 0, public_key: '1' * 32) }

    it 'delegates serialisation' do
      expect(object.to_borsh).to eq(
        [0x04, 0, 0, 0].map(&:chr).join + '1234' + [0x0].map(&:chr).join + '1' * 32
      )
    end

    context 'with incorreсt public_key size' do

      let(:key) { OpenStruct.new(key_type: 0, public_key: '1') }

      it 'raises error' do
        expect { object.to_borsh }.to raise_error ::Borsh::ArgumentError, 'key => public_key => ByteString length mismatch'
      end
    end
  end

  it "has a version number" do
    expect(Borsh::VERSION).not_to be nil
  end
end
