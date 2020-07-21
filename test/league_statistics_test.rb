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

  def test_highest_average_scoring_visitor
    skip

    assert_equal "team_name", @league_statistics.highest_average_scoring_visitor
  end

  def test_hash_creation_by_index
    expected = {"3"=>[0, 1, 4]}

    assert_equal expected, @league_statistics.hash_creation_by_index(@league_statistics.game_hash, "away_team_id").slice("3")
  end

  def test_pull_goals_by_index

    assert_equal [2, 2, 1], @league_statistics.pull_goals_by_index
  end

end
