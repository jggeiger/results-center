class ResultsController < ApplicationController
    def show

        begin
            election = Election.find(params[:election_id])
        rescue ActiveRecord::RecordNotFound => e
            @election_title = "Election not found"
            return
        end
        

        results = Election.get_results(params[:election_id])

        @election_title = election.title
        
        election.starts_at ? @election_start = "Start: " + election.starts_at.to_s : @election_start = "Start: N/A"
        election.ends_at ? @election_end = "End: " + election.ends_at.to_s : @election_end = "End: N/A"

        questions = JSON[results]["questions"]

        html = ""
        questions.each {|q|
            html = html + "<div class='container'>
                <h1>" + 
                    q["prompt"] +
                "</h1>
                <h2>" +
                    q["totals"].to_s +
                "</h2>
                <h2>" +
                    q["percentages"].to_s +
                "</h2>
                <h2>" +
                    q["winner_ids"].to_s +
                "</h2>
            </div>\n"
        }
        @questions = html

    end
end
