require_relative "game_team_data"
require_relative "game_data"
require_relative "team_data"
# Not sure which files we will really need yet

class SeasonStatistics
  def initialize()
    @coach_by_team_id = Hash.new{}
    @team_name_by_team_id = Hash.new{}
  end

  def all_games
    GameData.create_objects
  end

  def all_game_teams
    GameTeamData.create_objects
  end

  def all_teams
    TeamData.create_objects
  end

  def get_coach_by_team_id
    all_game_teams.each do |game_team|
      @coach_by_team_id[game_team.team_id] = game_team.head_coach
    end
    @coach_by_team_id
  end

  def get_team_name_by_team_id
    all_teams.each do |team|
      @team_name_by_team_id[team.team_id] = team.team_name
    end
    @team_name_by_team_id
  end

  def get_coach_win_percentage

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
