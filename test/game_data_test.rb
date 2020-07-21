require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_data'
require './lib/game'
require 'csv'

class GameDataTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/dummy_file_teams.csv'
    game_teams_path = './data/dummy_file_game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @game_data = GameData.new
    @table = CSV.parse(File.read('./data/games.csv'), headers: true)
  end

  def test_it_exists

    assert_instance_of GameData, @game_data
  end

  def test_it_can_create_many_objects
    line_index = 0
    all_games = []
    @table.size.times do
      game_data = GameData.new
      game_data.create_attributes(@table, line_index)
      all_games << game_data
      line_index += 1
    end
    assert_equal 7441, all_games.size
  end

end
