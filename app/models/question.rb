class Question < ApplicationRecord
  belongs_to :election

  validates :election_id, presence: true
  validates :prompt, presence: true
  validates :question_type, presence: true
  validates :position, presence: true

  scope :in_election, -> (election_id) {where(election: election_id)}

end
