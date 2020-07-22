require "minitest/autorun"
require "minitest/pride"
require "./lib/league_statistics"
require "./lib/instantiable"
include Instantiable
require 'csv'
require 'pry'

class LeagueStatisticsTest < Minitest::Test

  def setup
    @game_data = Instantiable.create_instances_of_game
    @team_data = Instantiable.create_instances_of_team
    @game_team_data = Instantiable.create_instances_of_team_game
    @league_statistics = LeagueStatistics.new(@game_data, @team_data, @game_team_data)
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_obtain_goals_per_game_by_team_id
    expected = {3=>[2, 2, 1, 2, 1],
                5=>[0, 1, 1, 0],
                6=>[3, 3, 2, 3, 3, 3, 4, 2, 1],
                17=>[1]
              }

    assert_equal expected, @league_statistics.obtain_goals_per_game_by_team_id
  end

  def test_obtain_goals_per_game_by_away_team_id
    expected = {3=>[2, 2, 1],
      5=>[1, 0],
      6=>[2, 3, 3, 4],
      17=>[1]
    }

    assert_equal expected, @league_statistics.obtain_goals_per_game_by_away_team_id
  end

  def test_highest_scoring_home_team

    assert_equal "FC Dallas", @league_statistics.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team

    assert_equal "Sporting Kansas City", @league_statistics.lowest_scoring_home_team
  end


  def test_highest_scoring_visitor

    assert_equal "FC Dallas", @league_statistics.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor

    assert_equal "Sporting Kansas City", @league_statistics.lowest_scoring_visitor
  end

  def test_convert_team_id_to_name

    assert_equal "New York City FC", @league_statistics.convert_team_id_to_name(9)
  end

  def test_best_offense

    assert_equal "FC Dallas", @league_statistics.best_offense
  end

  def test_worst_offense

    assert_equal "Sporting Kansas City", @league_statistics.worst_offense
  end
end
