class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :election, null: false, foreign_key: true
      t.string :prompt
      t.string :question_type
      t.integer :position

      t.timestamps
    end
  end
end
