require "minitest/autorun"
require "minitest/pride"
require "./lib/team_data"
require "csv"
class TeamDataTest < Minitest::Test

  def test_it_exists
    team_data = TeamData.new
    assert_instance_of TeamData, team_data
  end

  def test_it_can_create_many_objects
    all_teams = TeamData.create_objects

    assert_equal "1", all_teams[0].team_id
    assert_equal "Atlanta United", all_teams[0].team_name
  end

end
