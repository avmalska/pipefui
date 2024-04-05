module FormAnswerHelper
  def answer_field_for(form, text_type)
    case text_type
    when 'text'
      form.text_area :answers, name: 'answers[][answer]'
    when 'textarea'
      form.text_field :answers, name: 'answers[][answer]'
    else
      'unexpected field type'
    end
  end
end
