# require "minitest/autorun"
# require "minitest/pride"
# require "./lib/game_statistics"
# require 'mocha/minitest'
require "./test/test_helper"

class GameStatisticsTest < MiniTest::Test

  def setup
    @game_statistics = GameStatistics.new
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_game_statistics_can_inherit_game_array
    @game_statistics.stubs(:object_creation).returns("game array")
    assert_equal "game array", @game_statistics.object_creation
  end

  def test_total_score
    assert_equal 7441, @game_statistics.total_score.size
  end

  def test_win_data
    assert_equal 1517, @game_statistics.win_data[:ties]
  end

  def test_highest_total_score
    assert_equal 11, @game_statistics.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 0, @game_statistics.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 0.44, @game_statistics.percentage_home_wins
  end

  def test_percentage_vistor_wins
    assert_equal 0.36, @game_statistics.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.20, @game_statistics.percentage_ties
  end

  def test_it_can_count_games_by_season
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @game_statistics.count_of_games_by_season
  end

  def test_it_can_calc_avg_goals_per_game
    assert_equal 4.22, @game_statistics.average_goals_per_game
  end

  def test_it_can_calc_avg_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    assert_equal expected, @game_statistics.average_goals_by_season
  end
end
