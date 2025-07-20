class Voter < ApplicationRecord
  belongs_to :election

  scope :in_election, -> (election_id) {where(election: election_id)}

end
