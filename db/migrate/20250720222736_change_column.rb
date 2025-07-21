class ChangeColumn < ActiveRecord::Migration[8.0]
  def change
    change_column :elections, :status, :string, default: "pending"
  end
end
