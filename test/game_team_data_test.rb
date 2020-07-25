require "minitest/autorun"
require "minitest/pride"
require "./lib/game_team_data"
require "csv"

class GameTeamDataTest < Minitest::Test

  def test_it_exists
    game_team_data = GameTeamData.new
    assert_instance_of GameTeamData, game_team_data
  end

  def test_it_can_create_many_objects
    game_team_data = GameTeamData.create_objects

    assert_equal "away", game_team_data[0].hoa
    assert_equal "John Tortorella", game_team_data[0].head_coach
    assert_equal "8", game_team_data[0].shots
    assert_equal "44", game_team_data[0].tackles
  end

end
