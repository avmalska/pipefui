require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FormAnswerHelper. For example:
#
# describe FormAnswerHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FormAnswerHelper, type: :helper do
  describe '#answer_field_for' do
    let(:form) { double('form') }

    context 'when text type is "text"' do
      it 'returns a text area field' do
        expect(form).to receive(:text_area).with(:answers, name: 'answers[][answer]')
        helper.answer_field_for(form, 'text')
      end
    end

    context 'when text type is "textarea"' do
      it 'returns a text field' do
        expect(form).to receive(:text_field).with(:answers, name: 'answers[][answer]')
        helper.answer_field_for(form, 'textarea')
      end
    end

    context 'when text type is unexpected' do
      it 'returns an error message' do
        expect(helper.answer_field_for(form, 'invalid_type')).to eq('unexpected field type')
      end
    end
  end
end
