class Voter < ApplicationRecord
  belongs_to :election

  validates :election_id, presence: true
  # validates :email, presence: true -- optional in sample data
  validates :name, presence: true
  
  validates :access_token, presence: true
  validates :access_token, uniqueness: true

  scope :in_election, -> (election_id) {where(election: election_id)}

end
