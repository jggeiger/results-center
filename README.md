# “Results Center Project”

# Setup
'docker compose up' to run project

# Core Functionality

## Models
Only the models provided were used with minimal changes. 
-- status attribute of Election was changed to enum and defaulted to "pending"
-- some attributes, such as Voter ballot_cast_at, were given default values. In this case, nil
-- attributes that would not make sense to be missing (i.e. Question position) are required to be non-empty

## Methods
Two primary methods were added
-- Question.get_result(id) - Handles the bulk of the simple plurality algorithm, returning the 
   total votes, percentages, and winners of a given question in an election
   The method was placed in this class to avoid bulk inside of the results controller, as well as inside the Election method
   which generates the JSON result. While in this scenario, individual question results are not needed, 
   generating all results for a full election is much too heavy for one method

-- Election.get_result(id) - Collects the results of each question in the election, and composes them into the JSON
   response provided by the /results/:election_id endpoint
   Once again, this logic felt like it was too bulky to go in the controller, and fits well into the Election class

## Testing
For this project, I followed a test driven development approach for the most part. Having a suite of tests including
edge cases made the larger pieces of logic much easier to work through.

## Assumptions
In Question.get_result, it is assumed that within the ballot tally_payload: choices = {q_{question_id} : answer_id, ...} i.e. the ballot
response for a question with id=1 would be stored {"q_1" : ans_id}. This is how the vote is matched to the question. This is what I assumed
was being shown in the suggested JSON structure for storing ballot responses

## Other
-- Helper scopes added to models for some queries I found useful