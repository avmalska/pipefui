require 'rails_helper'

RSpec.describe 'FormAnswers', type: :request do
  describe 'GET /new_answer' do
    let!(:form) { create(:form) }
    it 'returns correct http status' do
      get answer_form_url(form.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      get answer_form_url(form.id)
      expect(response).to render_template(:new_answer)
    end

    it 'renders expected values' do
      get answer_form_url(form.id)
      expect(response.body).to include form.title.to_s
      expect(response.body).to include form.fields.first.name.to_s
    end
  end

  describe 'POST /answer' do
    let!(:form) { create(:form) }
    let!(:params) do
      {
        answers: form.fields.map do |form_field|
          { field_id: form_field.id, answer: 'a' }
        end
      }
    end

    it 'creates a new form_answer' do
      expect {
        post(answer_form_url(form.id), params:)
      }.to change(FormAnswer, :count).from(0).to(1)
    end

    it 'redirects to root' do
      post(answer_form_url(form.id), params:)

      expect(response).to redirect_to(root_url)
    end
  end
end