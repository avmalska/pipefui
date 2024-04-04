require 'rails_helper'

RSpec.describe FormFieldAnswer, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:answer) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:form) }
    it { is_expected.to belong_to(:form_answer) }
    it { is_expected.to belong_to(:field) }
  end
end
