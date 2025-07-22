module TallyStrategy

    class VoteCounter

        QUESTION_TYPES = [
            SINGLE_CHOICE = "single_choice"
        ]

        def initialize(question_id)
            @question_id = question_id
            @totals = nil
        end

        def call
            
            initialize_totals

            question = Question.find(@question_id)
            election_id = question.election_id
            ballots = Ballot.in_election(election_id)

            case question.question_type
            when SINGLE_CHOICE
                single_choice(ballots)
            end

            total_votes = @totals.values.sum
            percentages = Hash.new
            if total_votes > 0
                @totals.each { |ans, votes|
                    percentages[ans] = (votes.to_f/total_votes).truncate(2)
                }
            else
                return [[], {}, {}]
            end

            greatest_votes = @totals.values.max()
            winner_ids = []
            @totals.each { |ans, votes|
                if votes == greatest_votes
                    winner_ids << ans
                end
            }

            return [winner_ids.sort, @totals, percentages]

        end

        private

        #Init totals to {"ans_id" => 0, ...} for all valid answers
        def initialize_totals
            
            answers = Answer.to_question(@question_id)
            valid_answers = [] 
            answers.each{ |answer|
                valid_answers.append(answer.id.to_s)
            }

            @totals = Hash[valid_answers.zip(Array.new(valid_answers.length, 0))]

        end

        def single_choice(ballots)
            
            # Assumes ballot payload is ordered by question id i.e. choices = {q_{question_position} : ans_id, ...}
            q_id = "q_" + @question_id.to_s

            ballots.each { |b|

                choices = b.tally_payload["choices"]
                next if choices[q_id].nil?

                answer_id = choices[q_id].to_s
                next if @totals[answer_id].nil? #Invalid answers treated as blank ballot

                @totals[answer_id] = @totals[answer_id] + 1

            }

        end

        def ranked_choice(ballots)
        end

    end

    class ElectionResultsGetter

        def initialize(election_id)
        end

        def call
        end

    end


end