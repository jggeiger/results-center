class Ballot < ApplicationRecord
  belongs_to :voter

  scope :in_election, -> (election_id) {where(voter: Voter.in_election(election_id))}

end
