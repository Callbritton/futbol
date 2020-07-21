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

  def test_best_offense

    assert_equal "team_name", @league_statistics.best_offense
  end

end
