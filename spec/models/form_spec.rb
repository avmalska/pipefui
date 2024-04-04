require 'rails_helper'

RSpec.describe Form, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:fields).is_at_least(1) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:fields).dependent(:destroy) }
    it { is_expected.to have_many(:form_answers).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for(:fields) }
  end
end
