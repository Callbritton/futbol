require_relative "game_team_data"
require_relative "game_data"
require_relative "team_data"

class SeasonStatistics

  attr_reader :coach_by_team_id,
              :team_name_by_team_id,
              :total_wins_by_team_id,
              :tackles_by_team_id

  def initialize()
    @coach_by_team_id = Hash.new{}
    @team_name_by_team_id = Hash.new{}
    @total_wins_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @tackles_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @all_games = all_games_creation
    @all_game_teams = all_game_teams_creation
    @all_teams = all_teams_creation
    get_coach_by_team_id
    get_team_name_by_team_id
    get_total_wins_by_team_id
    get_tackles_by_team_id
  end

  def all_games_creation
    GameData.create_objects
  end

  def all_game_teams_creation
    GameTeamData.create_objects
  end

  def all_teams_creation
    TeamData.create_objects
  end

  def get_coach_by_team_id
    @all_game_teams.each do |game_team|
      @coach_by_team_id[game_team.team_id] = game_team.head_coach
    end
  end

  def get_team_name_by_team_id
    @all_teams.each do |team|
      @team_name_by_team_id[team.team_id] = team.team_name
    end
  end

  def get_total_wins_by_team_id
    @all_games.each do |game|
      if game.home_goals > game.away_goals
        @total_wins_by_team_id[game.home_team_id] += 1
      elsif game.home_goals < game.away_goals
        @total_wins_by_team_id[game.away_team_id] += 1
      end
    end
  end

  def get_tackles_by_team_id
    @all_game_teams.each do |game_teams|
      @tackles_by_team_id[game_teams.team_id] += game_teams.tackles
    end
  end

  def winningest_coach
    # winningest_coach	Name of the Coach with the best win percentage for the season	String
  end

  def worst_coach
    # worst_coach	Name of the Coach with the worst win percentage for the season	String
  end

  def most_accurate_team
    # most_accurate_team	Name of the Team with the best ratio of shots to goals for the season	String
  end

  def least_accurate_team
    # least_accurate_team	Name of the Team with the worst ratio of shots to goals for the season	String
  end

  def most_tackles
    # most_tackles	Name of the Team with the most tackles in the season	String
  end

  def fewest_tackles
    # fewest_tackles	Name of the Team with the fewest tackles in the season	String
  end

end
