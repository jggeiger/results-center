require "test_helper"

class ElectionTest < ActiveSupport::TestCase

  test "creating election" do 

    assert(Election.new(title: "Test_Election"), "Election not created properly")
    
    assert_raises(ArgumentError) { Election.new(title: "Test_Election", status:"Test") }

    assert_not(Election.new.save, "Saved an election with blank title")

  end

end
