# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Form, type: :request do
  describe 'GET /index' do
    let!(:form) { create(:form) }
    let!(:form2) { create(:form) }
    it 'returns correct http status' do
      get forms_url
      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      get forms_url
      expect(response).to render_template(:index)
    end

    it 'renders expected values' do
      get forms_url
      expect(response.body).to include form.title.to_s
      expect(response.body).to include form.fields.count.to_s

      expect(response.body).to include form2.title.to_s
      expect(response.body).to include form2.fields.count.to_s
    end
  end

  describe 'GET /show' do\
    let!(:form) { create(:form) }
    it 'returns correct http status' do
      get form_url(form.id)
      expect(response).to have_http_status(:ok)
    end

    it 'renders correct template' do
      get form_url(form.id)
      expect(response).to render_template(:show)
    end

    it 'renders expected values' do
      get form_url(form.id)
      expect(response.body).to include form.title.to_s
      expect(response.body).to include form.fields.first.name.to_s
    end
  end

  describe 'GET /new' do
    it 'returns correct http status' do
      get new_form_url
      expect(response).to have_http_status(:ok)
    end

    it 'renders correct template' do
      get new_form_url
      expect(response).to render_template(:new)
    end

    context 'when no session is set' do
      it 'creates a fields session param' do
        get new_form_url
        expect(request.session[:fields]).to match_array([])
      end
    end

    context 'when session param fields has values' do
      let(:params) { { name: 'field name', text_type: 'text' } }
      it 'builds the form with the fields' do
        get new_form_url
        post add_field_forms_url, params: { field: params }
        get new_form_url

        expect(response.body).to include params[:name]
      end
    end

  end

  describe 'GET /edit' do
    let!(:form) { create(:form) }
    it 'returns correct http status' do
      get edit_form_url(form.id)
      expect(response).to have_http_status(:ok)
    end

    it 'renders correct template' do
      get edit_form_url(form.id)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /create' do
    context 'with valid params' do
      let(:params) { { title: 'Form', fields_attributes: [{ name: 'nome', text_type: 'text' }] } }
      it 'creates a new form' do
        expect {
          post forms_url, params: { form: params }
        }.to change(Form, :count).from(0).to(1)
      end

      it 'redirects to root' do
        post forms_url, params: { form: params }

        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid params' do
      let(:params) { { title: '' } }
      it 'does not create a new form' do
        expect {
          post forms_url, params: { form: params }
        }.not_to change(Form, :count)
      end

      it 'returns correct http status' do
        post forms_url, params: { form: params }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /update' do
    let!(:form) { create(:form) }
    context 'with valid params' do
      let(:params) { { title: 'Andrey' } }
      it 'updates the form' do
        expect {
          put form_url(form.id), params: { form: params }
        }.to change { form.reload.title }.to('Andrey')
      end

      it 'redirects to root' do
        put form_url(form.id), params: { form: params }

        expect(response).to redirect_to(root_url)
      end
    end

    context 'with invalid params' do
      let(:params) { { title: '' } }
      it 'does not update the form' do
        expect {
          put form_url(form.id), params: { form: params }
        }.not_to(change { form.reload.title })
      end

      it 'returns correct http status' do
        put form_url(form.id), params: { form: params }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:form) { create(:form) }

    it 'destroys the form' do
      expect {
        delete form_url(form.id)
      }.to change(Form, :count).by(-1)
    end

    it 'redirects to correct url' do
      delete form_url(form.id)

      expect(response).to redirect_to(root_url)
    end
  end

  describe 'POST /add_field' do
    let!(:form) { create(:form) }
    let(:params) { { name: 'field name', text_type: 'text' } }

    it 'should append the field to the fields session param' do
      get new_form_url
      expect(request.session[:fields].count).to be(0)
      post add_field_forms_url, params: { field: params }
      post add_field_forms_url, params: { field: params }
      expect(request.session[:fields].count).to be(2)
    end
  end

  describe 'GET /delete_field' do
    let(:params) { { name: 'field name', text_type: 'text' } }
    it 'should delete the field from the session fields param' do
      get new_form_url
      post add_field_forms_url, params: { field: params }
      expect(request.session[:fields].count).to be(1)
      get delete_field_forms_url(0)
      expect(request.session[:fields].count).to be(0)
    end
  end

end