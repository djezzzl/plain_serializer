# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PlainSerializer::Base do
  let(:sub_serializer) do
    Class.new(described_class) do
      define_group :short, %i[tmp]

      def tmp(_entity)
        :tmp
      end
    end
  end

  let(:dummy_serializer) do
    sub = sub_serializer

    Class.new(described_class) do
      define_group :short, %i[something anything]
      define_group :sub_explicitly, [:something, sub: :tmp]
      define_group :sub_group, [:something, sub: :short]

      define_serializer :sub, sub
      define_attribute :something

      def anything(_entity)
        :anything
      end
    end
  end

  describe '#serialize' do
    let(:data) { double(something: :something, sub: double) }

    context 'with simple group' do
      subject(:serializer) { dummy_serializer.setup(:short, sub: :short) }

      it 'works' do
        expect(serializer.serialize(data)).to eq(
          something: :something,
          anything: :anything,
          sub: { tmp: :tmp }
        )
      end
    end

    context 'with sub explicit' do
      subject(:serializer) { dummy_serializer.setup(:short, :sub_explicitly) }

      it 'works' do
        expect(serializer.serialize(data)).to eq(
          something: :something,
          anything: :anything,
          sub: { tmp: :tmp }
        )
      end
    end

    context 'with sub group' do
      subject(:serializer) { dummy_serializer.setup(:short, :sub_group) }

      it 'works' do
        expect(serializer.serialize(data)).to eq(
          something: :something,
          anything: :anything,
          sub: { tmp: :tmp }
        )
      end
    end
  end
end
