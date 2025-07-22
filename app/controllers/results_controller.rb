class ResultsController < ApplicationController

    def show
        @results = TallyStrategy::ElectionResultsGetter.new(params[:election_id]).call

        render json: @results
    end
end
