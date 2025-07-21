class Election < ApplicationRecord

    validates :title, presence: true
    validates :status, presence: true
    enum :status, {pending: "pending", open: "open", closed: "closed"}

    def self.get_results(election_id)

        begin
            election = Election.find(election_id)
        rescue ActiveRecord::RecordNotFound => e
            return JSON[{}]
        end

        questions = Question.in_election(election_id)

        election_result = {
            "election_id" => election_id,
            "questions" => []
        }

        questions.each {|q|

            winner_ids, totals, percentages = Question.get_results(q.id)
            
            #Winner chosen based on lowest id/earliest created
            if !winner_ids.empty?
                winner_ids = winner_ids.first(1)
            end

            question_result = {
                "id" => q.id,
                "prompt" => q.prompt,
                "totals" => totals,
                "percentages" => percentages,
                "winner_ids" => winner_ids
            }

            election_result["questions"].append(question_result)

        }   

        return JSON[election_result]

    end

end
