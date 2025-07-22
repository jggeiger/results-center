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

    result = TallyStrategy::VoteCounter.new(question.id).call
    
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

    result = TallyStrategy::VoteCounter.new(question.id).call

    assert_equal(expected, result, "question result does not contain correct information when some ballots are empty")

  end

  test "vote count result with no ballots" do
    question = questions(:no_ballots)
    
    expected = [[], {}, {}]

    result = TallyStrategy::VoteCounter.new(question.id).call

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

    result = TallyStrategy::VoteCounter.new(question.id).call

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

    result = TallyStrategy::VoteCounter.new(question.id).call

    assert_equal(expected, result, "question result does not contain correct information when a ballot contains an invalid answer")

  end

  test "vote count result with ranked choice" do
    #a1 win
    #first round: a1:4, a2:3, a3:2
    #second round: a1:6, a2:3
    question = questions(:ranked_choice1_a1)

    ans1 = answers(:ranked_q1_a1).id.to_s
    ans2 = answers(:ranked_q1_a2).id.to_s
    ans3 = answers(:ranked_q1_a3).id.to_s

    expected = [
      [ans1],
      {
        ans1 => 6,
        ans2 => 3,
        ans3 => nil
      },
      {
        ans1 => 0.60,
        ans2 => 0.30,
        ans3 => nil
      }
    ]

    result = TallyStrategy::VoteCounter.new(question.id).call

    assert_equal(expected, result, "ranked_choice question result does not contain correct information")


  end

  test "vote count result with ranked choice, tie" do
    #a1a2 tie
    #first round: a1:3, a2:3, a3:2
    #second round: a1:4, a2:4
    question = questions(:ranked_choice2_a1a2)

    ans1 = answers(:ranked_q2_a1).id.to_s
    ans2 = answers(:ranked_q2_a2).id.to_s
    ans3 = answers(:ranked_q2_a3).id.to_s

    expected = [
      [ans1, ans2].sort,
      {
        ans1 => 4,
        ans2 => 4,
        ans3 => nil
      },
      {
        ans1 => 0.50,
        ans2 => 0.50,
        ans3 => nil
      }
    ]

    result = TallyStrategy::VoteCounter.new(question.id).call

    assert_equal(expected, result, "ranked_choice question result does not contain correct information when final stage tie occurs")


  end

  test "vote count result with ranked choice, tie before final stage" do
    #a2a3 tie then a1 win
    #first round: a1:4, a2:3, a3:3
    #second round: a1:6, a2:4
    question = questions(:ranked_choice3_a1a2a3)

    ans1 = answers(:ranked_q3_a1).id.to_s
    ans2 = answers(:ranked_q3_a2).id.to_s
    ans3 = answers(:ranked_q3_a3).id.to_s

    expected = [
      [ans1],
      {
        ans1 => 6,
        ans2 => 4,
        ans3 => nil
      },
      {
        ans1 => 0.60,
        ans2 => 0.40,
        ans3 => nil
      }
    ]

    result = TallyStrategy::VoteCounter.new(question.id).call

    assert_equal(expected, result, "ranked_choice question result does not contain correct information when early stage tie occurs")

  end

  test "vote count result with ranked choice, no ballots" do
    #no ballots
    #first round: terminates
    question = questions(:ranked_choice4_none)

    expected = [[], {}, {}]

    result = TallyStrategy::VoteCounter.new(question.id).call

    assert_equal(expected, result, "ranked_choice question result does not contain correct information when no ballots cast")

  end


end