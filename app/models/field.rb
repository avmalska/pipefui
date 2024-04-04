class Field < ApplicationRecord
  VALID_FIELD_TYPES = %w[text textarea].freeze

  belongs_to :form
  has_many :form_field_answers, dependent: :destroy

  validates :name,
            presence: true

  validates :text_type,
            presence: true,
            inclusion: { in: VALID_FIELD_TYPES }

end
