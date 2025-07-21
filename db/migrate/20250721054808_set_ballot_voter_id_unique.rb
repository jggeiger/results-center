class SetBallotVoterIdUnique < ActiveRecord::Migration[8.0]
  def change
    remove_index :ballots, :voter_id
    add_index :ballots, :voter_id, unique: true
  end
end
