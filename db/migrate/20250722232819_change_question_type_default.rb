class ChangeQuestionTypeDefault < ActiveRecord::Migration[8.0]
  def change
    change_column :questions, :question_type, :string, default: "single_choice"
  end
end
