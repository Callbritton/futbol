require_relative './game_data'
require_relative './game_team_data'
require_relative './team_data'
require_relative './game_statistics'
require_relative './league_statistics'
require_relative './season_statistics'
require 'csv'

class StatTracker

  def self.from_csv(data)
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    StatTracker.new(locations)
  end

  attr_reader :data #For testing. Eventually make a mock/stub so our test can pass without this

  def initialize(data)
    @data = data

    @game_outcomes = {
      :home_games_won => 0,
      :visitor_games_won => 0,
      :ties => 0
    }
    @all_games = all_games_creation
    @all_game_teams = all_game_teams_creation
    @all_teams = all_teams_creation

    @total_games = @all_games.size
    @games_per_season = Hash.new{ |hash, key| hash[key] = 0 }
    @total_goals_per_season = Hash.new{ |hash, key| hash[key] = 0 }
    @total_score = total_score
    @average_goals_per_season = Hash.new{}

    @team_name_by_id = Hash.new{}
    @goals_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @average_goals_by_id = Hash.new{}
    @goals_by_away_id = Hash.new{ |hash, key| hash[key] = 0 }
    @goals_by_home_id = Hash.new{ |hash, key| hash[key] = 0 }

    @season_by_game_id = Hash.new{}
    @coach_by_team_id = Hash.new{}
    @team_name_by_team_id = Hash.new{}
    @total_wins_by_team_id = Hash.new{ |hash, season| hash[season] = Hash.new{ |season_string, key| season_string[key] = 0}}
    @tackles_by_team_id = Hash.new{ |hash, season| hash[season] = Hash.new{ |season_string, key| season_string[key] = 0}}

    win_data

    get_team_name_by_id
    get_goals_by_id
    get_games_by_id
    get_goals_by_home_id
    get_goals_by_away_id
    get_average_goals_by_id

    get_season_by_game_id
    get_coach_by_team_id
    get_team_name_by_team_id
    get_total_wins_by_team_id_and_season
    get_tackles_by_team_id_and_season

  end

# ============= helper methods =============
  def all_games_creation
    GameData.create_objects
  end

  def all_game_teams_creation
    GameTeamData.create_objects
  end

  def all_teams_creation
    TeamData.create_objects
  end

  def total_score
    @all_games.map do |games|
      games.home_goals.to_i + games.away_goals.to_i
    end
  end

  def win_data
    @all_games.each do |games|
      if games.home_goals > games.away_goals
        @game_outcomes[:home_games_won] += 1
      elsif games.home_goals < games.away_goals
        @game_outcomes[:visitor_games_won] += 1
      else
        @game_outcomes[:ties] += 1
      end
    end
  end

  def total_goals_per_season
    @all_games.each do |game|
      if @total_goals_per_season.include?(game.season)
        @total_goals_per_season[game.season] += game.away_goals.to_i + game.home_goals.to_i
      else
        @total_goals_per_season[game.season] += game.away_goals.to_i + game.home_goals.to_i
      end
    end
    @total_goals_per_season
  end

  def get_team_name_by_id
    @all_teams.each do |team|
      @team_name_by_id[team.team_id] = team.team_name
    end
  end

  def get_average_goals_by_id
    @goals_by_id.each do |team_id, goal|
      @average_goals_by_id[team_id] = (goal.to_f / @games_played_by_id[team_id]).round(2)
    end
  end

  def get_goals_by_id
    @all_game_teams.each do |game_team|
      @goals_by_id[game_team.team_id] += game_team.goals.to_i
    end
  end

  def get_games_by_id
    @all_game_teams.each do |game_team|
      @games_played_by_id[game_team.team_id] += 1
    end
  end

  def get_goals_by_away_id
    @all_game_teams.each do |game_team|
      if game_team.hoa == "away"
        @goals_by_away_id[game_team.team_id] += game_team.goals.to_i
      end
    end
  end

  def get_goals_by_home_id
    @all_game_teams.each do |game_team|
      if game_team.hoa == "home"
        @goals_by_home_id[game_team.team_id] += game_team.goals.to_i
      end
    end
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
# ============= game_statistics methods =============
  def highest_total_score
    @total_score.max
  end

  def lowest_total_score
    @total_score.min
  end

  def percentage_home_wins
    home_wins = @game_outcomes[:home_games_won]
    decimal_home = home_wins.to_f / @total_games
    decimal_home.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_outcomes[:visitor_games_won]
    decimal_visitor = visitor_wins.to_f / @total_games
    decimal_visitor.round(2)
  end

  def percentage_ties
    total_ties = @game_outcomes[:ties]
    decimal_ties = total_ties.to_f / @total_games
    decimal_ties.round(2)
  end

  def count_of_games_by_season
    @all_games.each do |game|
      if @games_per_season.include?(game.season)
        @games_per_season[game.season] += 1
      else
        @games_per_season[game.season] = 1
      end
    end
    @games_per_season
  end

  def average_goals_per_game
    decimal_average = @total_score.sum.to_f / @total_games
    decimal_average.round(2)
  end

  def average_goals_by_season
    total_goals_per_season.each do |season, goals|
      average = goals.to_f / @games_per_season[season]
      @average_goals_per_season[season] = average.round(2)
    end
    @average_goals_per_season
  end
# ============= league_statistics methods =============
  def count_of_teams
    @all_teams.size
  end

  def best_offense
    best_offense_id = @average_goals_by_id.invert.max[1]
    @team_name_by_id[best_offense_id]
  end

  def worst_offense
    worst_offense_id = @average_goals_by_id.invert.min[1]
    @team_name_by_id[worst_offense_id]
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
# ============= season_statistics methods =============

# ============= team_statistics methods =============
end
