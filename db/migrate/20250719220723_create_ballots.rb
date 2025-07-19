class CreateBallots < ActiveRecord::Migration[8.0]
  def change
    create_table :ballots do |t|
      t.references :voter, null: false, foreign_key: true
      t.jsonb :tally_payload

      t.timestamps
    end
  end
end
