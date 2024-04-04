class CreateFormFieldAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :form_field_answers do |t|
      t.string :answer, null: false
      t.references :form, null: false, foreign_key: true
      t.references :form_answer, null: false, foreign_key: true
      t.references :field, null: false, foreign_key: true

      t.timestamps
    end
  end
end
