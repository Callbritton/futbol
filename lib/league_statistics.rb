require_relative "team_data"
require_relative "game_team_data"
class LeagueStatistics
  attr_reader :team_name_by_id,
              :goals_by_id,
              :games_played_by_id,
              :average_goals_by_id,
              :goals_by_away_id,
              :goals_by_home_id

  def initialize
    @team_name_by_id = Hash.new{}
    @goals_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @average_goals_by_id = Hash.new{}
    @goals_by_away_id = Hash.new{ |hash, key| hash[key] = 0 }
    @goals_by_home_id = Hash.new{ |hash, key| hash[key] = 0 }
    @all_game_teams = all_game_teams_creation
    @all_teams = all_teams_creation
    get_team_name_by_id
    get_goals_by_id
    get_games_by_id
    get_goals_by_home_id
    get_goals_by_away_id
    get_average_goals_by_id
  end

  def all_teams_creation
    TeamData.create_objects
  end

  def all_game_teams_creation
    GameTeamData.create_objects
  end

  def count_of_teams
    @all_teams.size
  end

  def get_team_name_by_id
    @all_teams.each do |team|
      @team_name_by_id[team.team_id] = team.team_name
    end
    @team_name_by_id
  end

  def best_offense
    best_offense_id = @average_goals_by_id.invert.max[1]
    @team_name_by_id[best_offense_id]
  end

  def worst_offense
    worst_offense_id = @average_goals_by_id.invert.min[1]
    @team_name_by_id[worst_offense_id]
  end

  def get_average_goals_by_id
    @goals_by_id.each do |team_id, goal|
      @average_goals_by_id[team_id] = (goal.to_f / @games_played_by_id[team_id]).round(2)
    end
    @average_goals_by_id
  end

  def get_goals_by_id
    @all_game_teams.each do |game_team|
      @goals_by_id[game_team.team_id] += game_team.goals
    end
    @goals_by_id
  end

  def get_games_by_id
    @all_game_teams.each do |game_team|
      @games_played_by_id[game_team.team_id] += 1
    end
    @games_played_by_id
  end

  def get_goals_by_away_id
    @all_game_teams.each do |game_team|
      if game_team.hoa == "away"
        @goals_by_away_id[game_team.team_id] += game_team.goals
      end
    end
    @goals_by_away_id
  end

  def get_goals_by_home_id
    @all_game_teams.each do |game_team|
      if game_team.hoa == "home"
        @goals_by_home_id[game_team.team_id] += game_team.goals
      end
    end
    @goals_by_home_id
  end

  def highest_scoring_visitor
    highest_scorer_away = @goals_by_away_id.invert.max[1]
    @team_name_by_id[highest_scorer_away]
  end

  def lowest_scoring_visitor
    lowest_scorer_away = @goals_by_away_id.invert.min[1]
    @team_name_by_id[lowest_scorer_away]
  end

  def highest_scoring_home_team
    highest_scorer_at_home = @goals_by_home_id.invert.max[1]
    @team_name_by_id[highest_scorer_at_home]
  end

  def lowest_scoring_home_team
    lowest_scorer_at_home = @goals_by_home_id.invert.min[1]
    @team_name_by_id[lowest_scorer_at_home]
  end
end
