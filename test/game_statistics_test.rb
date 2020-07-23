require "minitest/autorun"
require "minitest/pride"
require "./lib/game_statistics"
require "./lib/game_data"
require 'csv'
require 'pry'

class GameStatisticsTest < MiniTest::Test

  def setup
    @game_statistics = GameStatistics.new
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_game_statistics_is_an_instance_of_game_data
    assert_instance_of GameData, @game_statistics.all_games[0]
  end
end
