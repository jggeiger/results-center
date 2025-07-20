require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  test "question result contains proper information" do
    question = questions(:first_board)

    expected = [
      ["1"],
      {
        "0" => 1,
        "1" => 2
      },
      {
        "0" => 0.33,
        "1" => 0.66
      }
    ]

    result = Question.get_results(question.id)
    
    assert_equal(expected, result, "question result does not contain correct information")

  end
end
