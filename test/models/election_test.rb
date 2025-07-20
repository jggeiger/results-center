require "test_helper"

class ElectionTest < ActiveSupport::TestCase
  test "election results contain all relevant questions" do
    
    board = elections(:board)

    question1 = questions(:first_board)
    question2 = questions(:second_board)

    results = JSON[Election.get_results(board.id)]

    q_ids = []
    results["questions"].each { |q|
      q_ids.append(q["id"])
    }

    assert_includes(q_ids, question1.id, "Election results are missing a question")
    assert_includes(q_ids, question2.id, "Election results are missing a question")

  end

  test "election results contains all relevant questions when edge cases present" do
    board_edge = elections(:board_edge)

    tie = questions(:tie)
    empty_ballots = questions(:empty_ballots)
    invalid_answer = questions(:invalid_answer)

    results = JSON[Election.get_results(board_edge.id)]
    q_ids = []
    results["questions"].each { |q|
      q_ids.append(q["id"])
    }

    assert_includes(q_ids, tie.id, "Election results are missing question where tie occurs")
    assert_includes(q_ids, empty_ballots.id, "Election results are missing question where empty ballots present")
    assert_includes(q_ids, invalid_answer.id, "Election results are missing question where invalid answer present")

    no_ballots = elections(:no_ballots)
    no_ballots_question = questions(:no_ballots)

    results = JSON[Election.get_results(no_ballots.id)]
    q_id = results["questions"][0]["id"]

    assert_equal(q_id, no_ballots_question.id, "Election results are missing question when no ballots")

  end
end
