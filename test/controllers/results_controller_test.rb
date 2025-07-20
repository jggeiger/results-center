require "test_helper"

class ResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get results page" do
    election_id = Election.first.id
    get "/results/" + election_id.to_s
    assert_response :success
  end
end
