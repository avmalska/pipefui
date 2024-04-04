require 'rails_helper'

RSpec.describe FormAnswer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:form) }
    it { is_expected.to have_many(:form_field_answers).dependent(:destroy)  }
  end
end
