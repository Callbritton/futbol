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
    assert_instance_of GameData, @game_statistics.all_games[1]
  end

  def test_total_score
    assert_equal 5, @game_statistics.highest_total_score
    assert_equal 1, @game_statistics.lowest_total_score
  end

  def test_it_can_determine_percentages
    @game_statistics.win_data
    assert_equal 68.42, @game_statistics.percentage_of_home_wins
    assert_equal 26.32, @game_statistics.percentage_of_visitor_wins
    assert_equal 5.26, @game_statistics.percentage_of_ties
  end

  def test_it_can_count_games_by_season
    expected = {'20122013'=>19}
    assert_equal expected, @game_statistics.count_of_games_by_season
  end

  def test_it_can_calc_avg_goals_per_game
    assert_equal 3.68, @game_statistics.average_goals_per_game
  end

  def test_it_can_calc_avg_goals_by_season
    expected = {'20122013'=>3.68}
    assert_equal expected, @game_statistics.average_goals_per_season
  end
end
