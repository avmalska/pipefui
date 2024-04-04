class FormsController < ApplicationController
  before_action :set_form, only: %i[show edit update destroy]
  def index
    session.destroy
    @forms = Form.all
  end

  def show; end

  def new
    @form = Form.new
    if session[:fields].nil?
      session[:fields] = []
    else
      @form.fields.build(session[:fields])
    end
  end

  def create
    session.destroy
    @form = Form.new(form_params)

    if @form.save
      redirect_to root_path
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @form.update(update_form_params)
      redirect_to root_path
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  def destroy
    @form.destroy
    redirect_to root_path
  end

  def add_field
    @field = Field.new(field_params)
    session[:fields].append(@field)

    redirect_back(fallback_location: root_path)
  end

  def delete_field
    session[:fields].delete_at(params[:field_id].to_i)

    redirect_back(fallback_location: root_path)
  end

  private

  def set_form
    @form = Form.find(params[:id])
  end

  def field_params
    params[:field].permit(:name, :text_type)
  end

  def form_params
    params.require(:form).permit(:title, fields_attributes: %i[id name text_type])
  end

  def update_form_params
    params.require(:form).permit(:title)
  end
end
