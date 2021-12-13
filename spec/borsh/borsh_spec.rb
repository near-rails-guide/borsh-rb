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

        borsh key: 32

        def key
          'test'
        end
      end
    end

    it 'returns serialized result' do
      expect(klass.new.to_borsh).to eq('test')
    end
  end

  it "has a version number" do
    expect(Borsh::VERSION).not_to be nil
  end
end
