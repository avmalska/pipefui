# frozen_string_literal: true

class FormAnswerController < ApplicationController
  before_action :set_form, only: %i[new_answer answers detailed_answer]
  def new_answer
    @form_answer = FormAnswer.new
  end

  def answer
    @form_answer = FormAnswer.new(form_id: params[:form_id])
    @form_answer.form_field_answers.build(answer_params[:answers]) do |form_field_answer|
      form_field_answer.form_id = params[:form_id]
    end
    if @form_answer.save
      redirect_to root_url
    else
      redirect_to root_url, status: :unprocessable_entity
    end
  end

  def answers; end

  def detailed_answer
    @form_answer = FormAnswer.find(params[:form_answer_id])
  end

  private

  def set_form
    @form = Form.find(params[:form_id])
  end

  def answer_params
    params.permit(answers: %i[field_id answer])
  end


end
