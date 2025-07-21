require "test_helper"

class ResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get results page" do
    election_id = elections(:chair).id
    get "/results/" + election_id.to_s
    assert_response :success
  end

  test "GET returns correct JSON api response" do
    
    election_id = elections(:chair).id
    get "/results/" + election_id.to_s
    response = @response.body
    
    question = questions(:first_chair)

    answer1 = answers(:answer1)
    answer2 = answers(:answer2)
    answer3 = answers(:answer3)

    expected = {
      "election_id" => election_id.to_s,
      "questions" => [
        {
          "id" => question.id,
          "prompt" => question.prompt,
          "totals" => {
            answer1.id.to_s => 2,
            answer2.id.to_s => 0,
            answer3.id.to_s => 0
          },
          "percentages" => {
            answer1.id.to_s => 1.0,
            answer2.id.to_s => 0.0,
            answer3.id.to_s => 0.0
          },
          "winner_ids" => [answer1.id.to_s]
        }
      ]
    }


    assert_equal(JSON[response], expected)
  end

  test "GET election that does not exist" do
    
    get "/results/foo"
    response = @response.body

    assert_equal(JSON[response], {})

  end

end
