require "minitest/autorun"
require "minitest/pride"
require "./lib/league_statistics"
require "./lib/game"
require 'csv'
require 'pry'

class LeagueStatisticsTest < Minitest::Test

  def setup
    game_path = './data/dummy_file_games.csv'
    team_path = './data/dummy_file_teams.csv'
    game_teams_path = './data/dummy_file_game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @game_stats = Game.new()
    @team_stats = Game.new()
    game_array = CSV.read(@locations[:games])
    team_array = CSV.read(@locations[:teams])
    @game_stats.create_stat_hash_keys(game_array)
    @team_stats.create_stat_hash_keys(team_array)

    @league_statistics = LeagueStatistics.new(@game_stats.stat_hash, @team_stats.stat_hash)
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_it_has_attributes
    skip
    assert_equal [], @league_statistics.game_hash #dummy data call
    assert_equal [], @league_statistics.team_hash #dummy data call
  end

  def test_it_can_count_total_number_of_teams_in_data
    assert_equal 19, @league_statistics.teams_count
  end

  def test_data_size
    assert_equal 19, @league_statistics.data_size
  end

end
