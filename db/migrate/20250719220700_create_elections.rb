class CreateElections < ActiveRecord::Migration[8.0]
  def change
    create_table :elections do |t|
      t.string :title
      t.string :status
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
