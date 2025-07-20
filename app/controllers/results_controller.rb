class ResultsController < ApplicationController
    def show
        @election_id = params[:election_id]
    end
end
