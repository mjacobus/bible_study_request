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

  it 'requires uuid' do
    expect(described_class.new(attributes.except(:uuid))).not_to be_valid
  end

  it 'requires name' do
    expect(described_class.new(attributes.except(:name))).not_to be_valid
  end

  it 'requires email or phone' do
    visitor = described_class.new(attributes.except(:email, :phone))
    expect(visitor).not_to be_valid
    expect(visitor.errors[:phone]).not_to be_empty
    expect(visitor.errors[:email]).not_to be_empty
  end

  it 'is valid with only phone' do
    expect(described_class.new(attributes.except(:email))).to be_valid
  end

  it 'is valid with only email' do
    expect(described_class.new(attributes.except(:phone))).to be_valid
  end
end
