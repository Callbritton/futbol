require_relative "futbol_data"
require_relative "futbol_creatable"
include FutbolCreatable
require_relative "helpable"
include Helpable

class LeagueStatistics < FutbolData

  def initialize
    @all_teams       = FutbolCreatable.object_creation("teams")
    @all_game_teams  = FutbolCreatable.object_creation("game_teams")
    @team_name_by_id = Hash.new{}
    @goals_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @average_goals_by_id = Hash.new{}
    @goals_by_away_id = Hash.new{ |hash, key| hash[key] = 0 }
    @goals_by_home_id = Hash.new{ |hash, key| hash[key] = 0 }

  end

  def count_of_teams
    @all_teams.size
  end

  def offense_suite
    get_team_name_by_id
    average_goals_by_id
  end

  def best_offense
    offense_suite
    best_offense_id = @average_goals_by_id.invert.max[1]
    @team_name_by_id[best_offense_id]
  end

  def worst_offense
    offense_suite
    worst_offense_id = @average_goals_by_id.invert.min[1]
    @team_name_by_id[worst_offense_id]
  end

  def by_id_suite
    goals_by_id
    games_by_id
  end

  def average_goals_by_id
    by_id_suite
    @goals_by_id.each do |team_id, goal|
      @average_goals_by_id[team_id] = (goal.to_f / @games_played_by_id[team_id]).round(2)
    end
    @average_goals_by_id
  end

  def goals_by_id
    @all_game_teams.each do |game_team|
      @goals_by_id[game_team["team_id"]] += game_team["goals"].to_i
    end
    @goals_by_id
  end

  def games_by_id
    @all_game_teams.each do |game_team|
      @games_played_by_id[game_team["team_id"]] += 1
    end
    @games_played_by_id
  end

  def goals_by_away_id
    @games_by_away_id = Hash.new{ |hash, key| hash[key] = 0 }
    @all_game_teams.each do |game_team|
      if game_team["HoA"] == "away"
        @goals_by_away_id[game_team["team_id"]] += game_team["goals"].to_i
        @games_by_away_id[game_team["team_id"]] += 1
      end
    end
    @goals_by_away_id
  end

  def goals_by_home_id
    @games_by_home_id = Hash.new{ |hash, key| hash[key] = 0 }
    @all_game_teams.each do |game_team|
      if game_team["HoA"] == "home"
        @goals_by_home_id[game_team["team_id"]] += game_team["goals"].to_i
        @games_by_home_id[game_team["team_id"]] += 1
      end
    end
    @goals_by_home_id
  end

  def goals_by_hoa_id_suite
    goals_by_home_id
    goals_by_away_id
    get_team_name_by_id
  end

  def highest_scoring_visitor
    goals_by_hoa_id_suite
    @average_score_per_away_game = {}
    @goals_by_away_id.each do |away_team_id, goals|
      @average_score_per_away_game[away_team_id] = (goals.to_f / @games_by_away_id[away_team_id]).round(3)
    end
    highest_scorer_away = @average_score_per_away_game.invert.max[1]
    @team_name_by_id[highest_scorer_away]
  end

  def lowest_scoring_visitor
    goals_by_hoa_id_suite
    @average_score_per_away_game = {}
    @goals_by_away_id.each do |away_team_id, goals|
      @average_score_per_away_game[away_team_id] = (goals.to_f / @games_by_away_id[away_team_id]).round(3)
    end
    lowest_scorer_away = @average_score_per_away_game.invert.min[1]
    @team_name_by_id[lowest_scorer_away]
  end

  def highest_scoring_home_team
    goals_by_hoa_id_suite
    @average_score_per_home_game = {}
    @goals_by_home_id.each do |home_team_id, goals|
      @average_score_per_home_game[home_team_id] = (goals.to_f / @games_by_home_id[home_team_id]).round(3)
    end
    highest_scorer_at_home = @average_score_per_home_game.invert.max[1]
    @team_name_by_id[highest_scorer_at_home]
  end

  def lowest_scoring_home_team
    goals_by_hoa_id_suite
    @average_score_per_home_game = {}
    @goals_by_home_id.each do |home_team_id, goals|
      @average_score_per_home_game[home_team_id] = (goals.to_f / @games_by_home_id[home_team_id]).round(3)
    end
    lowest_scorer_at_home = @average_score_per_home_game.invert.min[1]
    @team_name_by_id[lowest_scorer_at_home]
  end
end
