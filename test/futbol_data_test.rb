# require "minitest/autorun"
# require "minitest/pride"
# require "./lib/futbol_data"
# require "mocha/minitest"
require "./test/test_helper"

class FutbolDataTest < Minitest::Test

  def test_create_chosen_data_set_for_team
    futbol = FutbolData.new("team")
    futbol.stubs(:teams).returns("team data array")
    assert_equal "team data array", futbol.teams
  end

  def test_create_chosen_data_set_for_game
    futbol2 = FutbolData.new("game")
    futbol2.stubs(:games).returns("game data array")
    assert_equal "game data array", futbol2.games
  end

  def test_create_chosen_data_set_for_game_team
    futbol3 = FutbolData.new("game_teams")
    futbol3.stubs(:game_teams).returns("game_teams data array")
    assert_equal "game_teams data array", futbol3.game_teams
  end

end
