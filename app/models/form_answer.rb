class FormAnswer < ApplicationRecord
  belongs_to :form
  has_many :form_field_answers, dependent: :destroy
end
