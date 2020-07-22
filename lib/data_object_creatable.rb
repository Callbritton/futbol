require './lib/game_data'
require './lib/team_data'
require './lib/game_team_data'
require 'csv'

module DataObjectCreatable

  def create_instances_of_game
    table = CSV.parse(File.read('./data/dummy_file_games.csv'), headers: true, converters: :numeric)
    line_index = 0
    all_game_data = []
    table.size.times do
      game_data = GameData.new
      game_data.create_attributes(table, line_index)
      all_game_data << game_data
      line_index += 1
    end
    all_game_data
  end

  def create_instances_of_team
    table = CSV.parse(File.read('./data/dummy_file_teams.csv'), headers: true, converters: :numeric)
    line_index = 0
    all_team_data = []
    table.size.times do
      team_data = TeamData.new
      team_data.create_attributes(table, line_index)
      all_team_data << team_data
      line_index += 1
    end
    all_team_data
  end

  def create_instances_of_team_game

  end
end