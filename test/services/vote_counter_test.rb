require "test_helper"

class VoteCounterTest < ActiveSupport::TestCase
  test "vote count result contains proper information" do
    question = questions(:first_board)

    ans0 = answers(:answer4).id.to_s
    ans1 = answers(:answer5).id.to_s

    expected = [
      [ans1],
      {
        ans0 => 1,
        ans1 => 2
      },
      {
        ans0 => 0.33,
        ans1 => 0.66
      }
    ]

    result = TallyStrategy::VoteCounter.get_results(question.id)
    
    assert_equal(expected, result, "question result does not contain correct information")

  end

  test "vote count result with nil ballots" do
    question = questions(:empty_ballots)

    ans0 = answers(:answer8).id.to_s
    ans1 = answers(:answer9).id.to_s

    expected = [
      [ans0],
      {
        ans0 => 2,
        ans1 => 0
      },
      {
        ans0 => 1.00,
        ans1 => 0
      }
    ]

    result = TallyStrategy::VoteCounter.get_results(question.id)

    assert_equal(expected, result, "question result does not contain correct information when some ballots are empty")

  end

  test "vote count result with no ballots" do
    question = questions(:no_ballots)
    
    expected = [[], {}, {}]

    result = TallyStrategy::VoteCounter.get_results(question.id)

    assert_equal(expected, result, "question result does not contain correct information when no ballots cast")

  end

  test "vote count result with tie" do
    question = questions(:tie)

    ans0 = answers(:answer12).id.to_s
    ans1 = answers(:answer13).id.to_s

    expected = [
      [ans0, ans1].sort,
      {
        ans0 => 2,
        ans1 => 2
      },
      {
        ans0 => 0.50,
        ans1 => 0.50
      }
    ]

    result = TallyStrategy::VoteCounter.get_results(question.id)

    assert_equal(expected, result, "question result does not contain correct information when tie occurs")

  end

  test "vote count result with an invalid ballot answer" do
    question = questions(:invalid_answer)

    ans0 = answers(:answer14).id.to_s
    ans1 = answers(:answer15).id.to_s

    expected = [
      [ans0],
      {
        ans0 => 2,
        ans1 => 1
      },
      {
        ans0 => 0.66,
        ans1 => 0.33,
      }
    ]

    result = TallyStrategy::VoteCounter.get_results(question.id)

    assert_equal(expected, result, "question result does not contain correct information when a ballot contains an invalid answer")

  end
end