class Form < ApplicationRecord
  has_many :fields, dependent: :destroy
  accepts_nested_attributes_for :fields
  has_many :form_answers, dependent: :destroy

  validates :title,
            presence: true

  validates :fields,
            length: { minimum: 1 }

end
