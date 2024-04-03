class CreateForms < ActiveRecord::Migration[7.1]
  def change
    create_table :forms do |t|
      t.string :title, null: false
      t.boolean :can_answer, null: false, default: true

      t.timestamps
    end
  end
end
