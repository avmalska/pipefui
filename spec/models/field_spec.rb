require 'rails_helper'

RSpec.describe Field, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:text_type) }
    it { is_expected.to validate_inclusion_of(:text_type).in_array(%w[text textarea]) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:form) }
    it { is_expected.to have_many(:form_field_answers).dependent(:destroy) }
  end
end
