require "minitest/autorun"
require "minitest/pride"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test

  def test_it_exists
    assert_instance_of StatTracker, stat_tracker
  end

  #def test_it_has_attributes
  #end

end
