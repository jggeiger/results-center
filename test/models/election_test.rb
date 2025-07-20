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
end
