class Question < ApplicationRecord
  belongs_to :election

  validates :election_id, presence: true
  validates :prompt, presence: true
  validates :question_type, presence: true
  validates :position, presence: true

  scope :in_election, -> (election_id) {where(election: election_id)}

  def self.get_results(question_id)

    question = Question.find(question_id)
    election_id = question.election_id

    ballots = Ballot.in_election(election_id)

    answers = Answer.to_question(question_id)
    valid_answers = []
    totals = Hash.new
    answers.each{ |a|
      valid_answers.append(a.id)
      totals[a.id.to_s] = 0
    }

    # Assumes ballot payload is ordered by question position
    q_id = question.position.to_s

    ballots.each { |b|
      choices = b.tally_payload["choices"]
      totals[choices[q_id].to_s] = totals.fetch(choices[q_id].to_s, 0) + 1 if (choices[q_id] != nil && valid_answers.include?(choices[q_id])) #Invalid answers treated as nil
    }

    total_votes = totals.values.sum
    greatest_votes = totals.values.max()
    winner_ids = []
    percentages = Hash.new
    if total_votes > 0
        totals.each { |ans, votes|
            percentages[ans] = (votes.to_f/total_votes).truncate(2)

            if votes == greatest_votes
                winner_ids << ans
            end

        }
    else
        return [[], {}, {}]
    end

    return [winner_ids.sort, totals, percentages]

  end

end
