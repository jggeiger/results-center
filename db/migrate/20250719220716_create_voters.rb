class CreateVoters < ActiveRecord::Migration[8.0]
  def change
    create_table :voters do |t|
      t.references :election, null: false, foreign_key: true
      t.string :email
      t.string :name
      t.string :access_token
      t.datetime :ballot_cast_at

      t.timestamps
    end
    add_index :voters, :access_token, unique: true
  end
end
