class ResultsController < ApplicationController
    def show
        @results = Election.get_results(params[:election_id])

        render json: @results
    end
end
