module TallyStrategy

    class VoteCounter < ApplicationService

        def initialize(:question_id)
        end

        def call
        end

        private

        def single_choice
        end

        def ranked_choice
        end

    end

    class ElectionResultsGetter < ApplicationService

        def initialize(:election_id)
        end

        def call
        end

    end



end