require_relative "game_team_data"
require_relative "game_data"
require_relative "team_data"

class SeasonStatistics

  attr_reader :seasons,
              :coach_by_team_id,
              :team_name_by_team_id,
              :total_wins_by_team_id,
              :tackles_by_team_id

  def initialize()
    @season_by_game_id = Hash.new{}
    @coach_by_team_id = Hash.new{}
    @team_name_by_team_id = Hash.new{}
    @total_wins_by_team_id = Hash.new{ |hash, season| hash[season] = Hash.new{ |season, key| season[key] = 0}}
    @tackles_by_team_id = Hash.new{ |hash, season| hash[season] = Hash.new{ |season, key| season[key] = 0}}
    @all_games = all_games_creation
    @all_game_teams = all_game_teams_creation
    @all_teams = all_teams_creation
    get_season_by_game_id
    get_coach_by_team_id
    get_team_name_by_team_id
    get_total_wins_by_team_id_and_season
    get_tackles_by_team_id_and_season
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

  def get_season_by_game_id
    @all_games.each do |game|
      @season_by_game_id[game.game_id] = game.season
    end
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

  def get_total_wins_by_team_id_and_season
    @all_games.each do |game|
      season = @season_by_game_id[game.game_id]
      if game.home_goals > game.away_goals
        @total_wins_by_team_id[season][game.home_team_id] += 1
      elsif game.home_goals < game.away_goals
        @total_wins_by_team_id[season][game.away_team_id] += 1
      end
    end
  end

  def get_tackles_by_team_id_and_season
    @all_game_teams.each do |game_teams|
      season = @season_by_game_id[game_teams.game_id]
      @tackles_by_team_id[season][game_teams.team_id] += game_teams.tackles.to_i
    end
  end

  def winningest_coach_by_season(season)
    # winningest_coach	Name of the Coach with the best win percentage for the season	String
  end

  def worst_coach_by_season(season)
    # worst_coach	Name of the Coach with the worst win percentage for the season	String
  end

  def most_accurate_team_by_season(season)
    # most_accurate_team	Name of the Team with the best ratio of shots to goals for the season	String
  end

  def least_accurate_team_by_season(season)
    # least_accurate_team	Name of the Team with the worst ratio of shots to goals for the season	String
  end

  def most_tackles_by_season(season)
    # most_tackles	Name of the Team with the most tackles in the season	String
  end

  def fewest_tackles_by_season(season)
    # fewest_tackles	Name of the Team with the fewest tackles in the season	String
  end

end
