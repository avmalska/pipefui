class FormAnswer < ApplicationRecord
  belongs_to :form
  has_many :form_field_answers, dependent: :destroy
  accepts_nested_attributes_for :form_field_answers
end
