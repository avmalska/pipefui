class CreateFields < ActiveRecord::Migration[7.1]
  def change
    create_table :fields do |t|
      t.string :name, null: false
      t.string :text_type, null: false
      t.references :form, null: false, foreign_key: true

      t.timestamps
    end
  end
end
