require 'chatbot/path_finder'
require 'test/unit'

# require 'test/test_helper.rb'

class TestPathFinder < Test::Unit::TestCase
#  include TestHelper
  
  def setup
    @finder = Chatbot::PathFinder.new(file)
  end

  def teardown
    # after every test
  end

  def test_shortest_pat
    path = @finder.path_finder("a0","b2")
    assert(path.is_a?(Array))
    assert(path.any?)
    answer = ["a0","b0","bs1","b2"] # richtigen Pfad finden
    assert_equal(answer,path)
    #assert()
    #assert_match
    #asser_equal
    #assert_raise
    #assert_nothig_raised
    #assert_block
    #assert_respond_to
    # ...
  end


  private
  def xxx
  end
end
