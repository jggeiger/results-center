class Ballot < ApplicationRecord
  belongs_to :voter
  validates :voter_id, presence: true

  scope :in_election, -> (election_id) {where(voter: Voter.in_election(election_id))}

end
