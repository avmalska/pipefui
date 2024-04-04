class FormFieldAnswer < ApplicationRecord
  belongs_to :form
  belongs_to :form_answer
  belongs_to :field

  validates :answer,
            presence: true
end
