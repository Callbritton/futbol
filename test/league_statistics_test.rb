require "minitest/autorun"
require "minitest/pride"
require "./lib/league_statistics"
require "./lib/game_data"
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
    @table = CSV.parse(File.read('./data/dummy_file_games.csv'), headers: true)
    line_index = 0
    @all_games = []
    @table.size.times do
      game_data = GameData.new
      game_data.create_attributes(@table, line_index)
      @all_games << game_data
      line_index += 1
    end
    @league_statistics = LeagueStatistics.new(@all_games)
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_best_offense

    assert_equal "team_name", @league_statistics.best_offense
  end

end
