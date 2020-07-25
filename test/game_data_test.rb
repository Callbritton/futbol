require "minitest/autorun"
require "minitest/pride"
require "./lib/game_data"
require "csv"

class GameDataTest < Minitest::Test

  def test_it_exists
    game_data = GameData.new

    assert_instance_of GameData, game_data
  end

  def test_it_can_create_many_objects
    all_games = GameData.create_objects

    assert_equal "2012030221", all_games[0].game_id
  end

end
