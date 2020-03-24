# frozen_string_literal: true

class Visitor < ApplicationRecord
  validates :uuid, presence: true
end
