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

  test "question result with nil ballots" do
    question = questions(:empty_ballots)

    expected = [
      ["1"],
      {
        "0" => 0,
        "1" => 2
      },
      {
        "0" => 1.00,
        "1" => 0
      }
    ]

    result = Question.get_results(question.id)
    puts "nil ballots", result

    assert_equal(expected, result, "question result does not contain correct information when some ballots are empty")

  end

  test "question result with no ballots" do
    question = questions(:no_ballots)
    
    expected = [[], {}, {}]

    result = Question.get_results(question.id)
    puts "no ballots", result

    assert_equal(expected, result, "question result does not contain correct information when no ballots cast")

  end

  test "question result with tie" do
    question = questions(:tie)

    expected = [
      ["0","1"],
      {
        "0" => 2,
        "1" => 2
      },
      {
        "0" => 0.50,
        "1" => 0.50
      }
    ]

    result = Question.get_results(question.id)
    puts "tie", result

    assert_equal(expected, result, "question result does not contain correct information when tie occurs")

  end

  test "question result with an invalid ballot answer" do
    question = questions(:invalid_answer)

    expected = [
      ["0"],
      {
        "0" => 2,
        "1" => 1
      },
      {
        "0" => 0.66,
        "1" => 0.33,
      }
    ]

    result = Question.get_results(question.id)
    puts "invalid_answer", result

    assert_equal(expected, result, "question result does not contain correct information when a ballot contains an invalid answer")

  end

end
