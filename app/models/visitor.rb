# frozen_string_literal: true

class Visitor < ApplicationRecord
  validates :uuid, presence: true
  validates :name, presence: true
  validate :email_or_phone_validation

  private

  def email_or_phone_validation
    if phone.present? || email.present?
      return
    end

    errors.add(:email, 'Por favor informe email ou telefone')
    errors.add(:phone, 'Por favor informe email ou telefone')
  end
end
