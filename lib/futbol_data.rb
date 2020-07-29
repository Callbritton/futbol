require "csv"
class FutbolData

  attr_accessor :games, :teams, :game_teams

  def initialize(passed)
    @passed = passed
    @data_location = nil
    create_objects
  end

  def create_objects
    chosen_data_set # returns correct @data_location
    if @passed == 'teams'
      case_is_team
    elsif @passed == 'games'
      case_is_game
    elsif @passed == 'game_teams'
      case_is_game_teams
    end
  end

  def chosen_data_set
    case @passed
      when "teams"
        @data_location = './data/teams.csv'
      when "games"
        @data_location = './data/games.csv'
      when "game_teams"
        @data_location = './data/game_teams.csv'
    end
    @data_location
  end

  def case_is_team
    @teams = []
    csv_data = CSV.read(@data_location, headers: true)
    csv_data.each do |specific_data|
      @teams << specific_data
    end
    @teams
  end

  def case_is_game
    @games = []
    csv_data = CSV.read(@data_location, headers: true)
    csv_data.each do |specific_data|
      @games << specific_data
    end
    @games
  end

  def case_is_game_teams
    @game_teams = []
    csv_data = CSV.read(@data_location, headers: true)
    csv_data.each do |specific_data|
      @game_teams << specific_data
    end
    @game_teams
  end

  def team_info(passed_id)
    @team_info_by_id = Hash.new
    @all_teams.each do |team|
      if passed_id == team["team_id"]
        assign_team_info(team)
      end
    end
    @team_info_by_id
  end

  def assign_team_info(team)
    @team_info_by_id["team_id"] = team["team_id"]
    @team_info_by_id["franchise_id"] = team["franchiseId"]
    @team_info_by_id["team_name"] = team["teamName"]
    @team_info_by_id["abbreviation"] = team["abbreviation"]
    @team_info_by_id["link"] = team["link"]
  end

  def collect_game_objects_by_team_id(passed_id)
    @by_team_id_game_objects = []
    @all_games.each do |game_object|
      if game_object["home_team_id"] == passed_id
        @by_team_id_game_objects << game_object
      elsif game_object["away_team_id"] == passed_id
        @by_team_id_game_objects << game_object
      end
    end
  end

  def count_of_teams
    @all_teams.size
  end

  def create_coach_by_team_id(season)
    @coach_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @all_game_teams.each do |game_by_team|
      if game_by_team["game_id"][0..3] == season[0..3]
        @coach_by_team_id[game_by_team["team_id"]] = game_by_team["head_coach"]
      end
    end
  end

  def by_id_suite
    goals_by_id
    games_by_id
  end
  
end
