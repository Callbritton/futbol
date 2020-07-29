require "minitest/autorun"
require "minitest/pride"
require "./lib/season_statistics"
require 'mocha/minitest'

class SeasonStatisticsTest < Minitest::Test

  def setup
    @season_statistics = SeasonStatistics.new
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

  # Update tests for all new helpers excluding suite

  def test_it_can_print_best_coach_by_season
    assert_equal "Claude Julien", @season_statistics.winningest_coach("20132014")
  end

  def test_it_can_print_worst_coach_by_season
    # assert_equal "Peter Laviolette", @season_statistics.worst_coach("20132014")
    assert_equal "Craig MacTavish", @season_statistics.worst_coach("20142015")
  end

  def test_can_find_most_and_least_accurate_teams_by_season
    assert_equal "Real Salt Lake", @season_statistics.most_accurate_team("20132014")
    assert_equal "Toronto FC", @season_statistics.most_accurate_team("20142015")
    assert_equal "New York City FC", @season_statistics.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @season_statistics.least_accurate_team("20142015")
  end

  def test_can_find_most_and_least_tackles_by_team_by_season
    assert_equal "FC Cincinnati", @season_statistics.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @season_statistics.most_tackles("20142015")
    assert_equal "Atlanta United", @season_statistics.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @season_statistics.fewest_tackles("20142015")
  end

end
