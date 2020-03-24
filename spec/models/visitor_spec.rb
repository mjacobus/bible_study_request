# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Visitor, type: :model do
  before do
    described_class.create!(attributes)
  end

  let(:attributes) do
    {
      uuid: 'the-uuid',
      email: 'the-email',
      name: 'the-name',
      phone: 'the-phone',
      cid: 'the-cid'
    }
  end

  it 'creates all attributes' do
    visitor = described_class.last

    expect(visitor.uuid).to eq(attributes[:uuid])
    expect(visitor.email).to eq(attributes[:email])
    expect(visitor.name).to eq(attributes[:name])
    expect(visitor.phone).to eq(attributes[:phone])
    expect(visitor.cid).to eq(attributes[:cid])
  end

  it 'is valid with only uuid' do
    expect(described_class.new(uuid: 'uuid')).to be_valid
  end

  it 'requires uuid' do
    expect(described_class.new).not_to be_valid
  end
end
