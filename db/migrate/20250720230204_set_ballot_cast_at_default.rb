class SetBallotCastAtDefault < ActiveRecord::Migration[8.0]
  def change
    change_column_default :voters, :ballot_cast_at, :datetime, default: nil
  end
end
