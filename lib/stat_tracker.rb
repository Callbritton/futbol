require_relative "futbol_data"
require_relative "futbol_creatable"
require_relative "helpable"
include Helpable
include FutbolCreatable
require 'csv'

class StatTracker < FutbolData

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

  attr_reader :data

  def initialize(data)
    @data = data

    @all_games       = FutbolCreatable.object_creation("games")
    @all_teams       = FutbolCreatable.object_creation("teams")
    @all_game_teams  = FutbolCreatable.object_creation("game_teams")
# =====game_statistics=====
    @total_games = @all_games.size
    @total_goals_per_season = Hash.new{ |hash, key| hash[key] = 0 }
    # =====league_statistics=====
    @team_name_by_id = Hash.new{}
    @goals_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_id = Hash.new{ |hash, key| hash[key] = 0 }
    @average_goals_by_id = Hash.new{}
    @goals_by_away_id = Hash.new{ |hash, key| hash[key] = 0 }
    @goals_by_home_id = Hash.new{ |hash, key| hash[key] = 0 }
    # =====season_statistics=====
    @by_season_game_objects = []
    @counter_wins_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    # =====team_statistics=====
    get_team_name_by_id
  end
# ============= game_statistics methods =============
  def total_score
    @all_games.map do |games|
      games["home_goals"].to_i + games["away_goals"].to_i
    end
  end

  def highest_total_score
    total_score.max
  end

  def lowest_total_score
    total_score.min
  end

  def tally_goals(games)
    if games["home_goals"] > games["away_goals"]
      @game_outcomes[:home_games_won] += 1
    elsif games["home_goals"] < games["away_goals"]
      @game_outcomes[:visitor_games_won] += 1
    else
      @game_outcomes[:ties] += 1
    end
  end

  def win_data
    @game_outcomes = Hash.new{ |hash, key| hash[key] = 0 }
    @all_games.each do |games|
      tally_goals(games)
    end
  end

  def percentage_suite
    win_data
    @home_wins = @game_outcomes[:home_games_won]
    @visitor_wins = @game_outcomes[:visitor_games_won]
    @total_ties = @game_outcomes[:ties]
  end

  def percentage_home_wins
    percentage_suite
    decimal_home = @home_wins.to_f / @total_games
    decimal_home.round(2)
  end

  def percentage_visitor_wins
    percentage_suite
    decimal_visitor = @visitor_wins.to_f / @total_games
    decimal_visitor.round(2)
  end

  def percentage_ties
    percentage_suite
    decimal_ties = @total_ties.to_f / @total_games
    decimal_ties.round(2)
  end

  def count_of_games_by_season
    @games_per_season = Hash.new{ |hash, key| hash[key] = 0 }
    @all_games.each do |game|
      @games_per_season[game["season"]] += 1
    end
    @games_per_season
  end

  def average_goals_per_game
    decimal_average = total_score.sum.to_f / @total_games
    decimal_average.round(2)
  end

  def total_goals
    @all_games.each do |game|
      @total_goals_per_season[game["season"]] += game["away_goals"].to_i + game["home_goals"].to_i
    end
    @total_goals_per_season
  end

  def average_goals_by_season
    count_of_games_by_season
    total_goals
    @average_goals_per_season = Hash.new
    @total_goals_per_season.each do |season, goals|
      average = goals.to_f / @games_per_season[season]
      @average_goals_per_season[season] = average.round(2)
    end
    @average_goals_per_season
  end
# ============= league_statistics methods =============
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
# ============= season_statistics methods =============
  def create_coach_by_team_id
    @coach_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @all_game_teams.each do |game_by_team|
      @coach_by_team_id[game_by_team["team_id"]] = game_by_team["head_coach"]
    end
  end

  def collect_game_objects_by_season(season)
    @all_games.each do |game_object|
      if season == game_object["season"]
        @by_season_game_objects << game_object
      end
    end
  end

  def total_games_played_by_season(game)
    @games_played_by_team_id[game["away_team_id"]] += 1
    @games_played_by_team_id[game["home_team_id"]] += 1
  end

  def total_wins_for_home(game)
    @counter_wins_team_id[game["home_team_id"]] += 1
    @counter_wins_team_id[game["away_team_id"]] += 0
  end

  def total_wins_for_away(game)
    @counter_wins_team_id[game["away_team_id"]] += 1
    @counter_wins_team_id[game["home_team_id"]] += 0
  end

  def total_wins_by_season
    @by_season_game_objects.each do |season_game_object|
      total_games_played_by_season(season_game_object)
      if season_game_object["home_goals"] > season_game_object["away_goals"]
        total_wins_for_home(season_game_object)
      elsif season_game_object["away_goals"] > season_game_object["home_goals"]
        total_wins_for_away(season_game_object)
      end
    end
  end

  def win_percentage_by_season
    @win_percentage = {}
    @games_played_by_team_id.each do |id, total_games|
      @win_percentage[id] = (@counter_wins_team_id[id].to_f / total_games).round(3)
    end
  end

  def winningest_and_worst_suite(season)
    create_coach_by_team_id
    collect_game_objects_by_season(season)
    total_wins_by_season
    win_percentage_by_season
  end

  def winningest_coach(season)
    winningest_and_worst_suite(season)
    max_team_id = @win_percentage.invert.max[1]
    @coach_by_team_id[max_team_id]
  end

  def worst_coach(season)
    winningest_and_worst_suite(season)
    min_team_id = @win_percentage.invert.min[1]
    @coach_by_team_id[min_team_id]
  end

  def collect_game_team_objects_by_season(season)
    @by_season_game_team_objects = []
    @all_game_teams.each do |game_team_object|
      if season[0..3] == game_team_object["game_id"][0..3]
        @by_season_game_team_objects << game_team_object
      end
    end
  end

  def shots_by_team_id_by_season
    @shots_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_team_objects.each do |season_game_team_object|
      @shots_by_team_id[season_game_team_object["team_id"]] += season_game_team_object["shots"].to_i
    end
  end

  def goals_by_team_id_by_season
    @goals_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_team_objects.each do |season_game_team_object|
      @goals_by_team_id[season_game_team_object["team_id"]] += season_game_team_object["goals"].to_i
    end
  end

  def shot_accuracy_by_team_id_by_season
    @shot_accuracy_by_team_id = Hash.new
    @goals_by_team_id.keys.each do |key|
      shot_accuracy = @goals_by_team_id[key].to_f / @shots_by_team_id[key]
      @shot_accuracy_by_team_id[key] = shot_accuracy
    end
  end

  def shot_accuracy_suite(season)
    collect_game_team_objects_by_season(season)
    shots_by_team_id_by_season
    goals_by_team_id_by_season
    shot_accuracy_by_team_id_by_season
  end

  def most_accurate_team(season)
    shot_accuracy_suite(season)
    @team_name_by_id[@shot_accuracy_by_team_id.invert.max[1]]
  end

  def least_accurate_team(season)
    shot_accuracy_suite(season)
    @team_name_by_id[@shot_accuracy_by_team_id.invert.min[1]]
  end

  def tackles_by_team_id_by_season(season)
    collect_game_team_objects_by_season(season)
    @tackles_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_team_objects.each do |season_game_team_object|
      @tackles_by_team_id[season_game_team_object["team_id"]] += season_game_team_object["tackles"].to_i
    end
  end

  def most_tackles(season)
    tackles_by_team_id_by_season(season)
    @team_name_by_id[@tackles_by_team_id.invert.max[1]]
  end

  def fewest_tackles(season)
    tackles_by_team_id_by_season(season)
    @team_name_by_id[@tackles_by_team_id.invert.min[1]]
  end
# ============= team_statistics methods =============
  def team_info(passed_id)
    @team_info_by_id = Hash.new
    @all_teams.each do |team|
      if passed_id == team["team_id"] # Remove  when spec harness info updates
        @team_info_by_id["team_id"] = team["team_id"]
        @team_info_by_id["franchise_id"] = team["franchiseId"]
        @team_info_by_id["team_name"] = team["teamName"]
        @team_info_by_id["abbreviation"] = team["abbreviation"]
        @team_info_by_id["link"] = team["link"]
      end
    end
    @team_info_by_id
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

  def total_games_by_season_by_team_id
    @total_games_by_season = Hash.new{ |hash, key| hash[key] = 0 }
    @by_team_id_game_objects.each do |game|
      @total_games_by_season[game["season"]] += 1
    end
  end

  def total_wins_by_season_by_team_id(passed_id)
    @total_wins_by_season = Hash.new{ |hash, key| hash[key] = 0 }
    @by_team_id_game_objects.each do |game|
      if passed_id == game["away_team_id"] && game["away_goals"] > game["home_goals"]
        @total_wins_by_season[game["season"]] += 1
      elsif passed_id == game["home_team_id"] && game["home_goals"] > game["away_goals"]
        @total_wins_by_season[game["season"]] += 1
      elsif passed_id == game["away_team_id"] && game["away_goals"] < game["home_goals"]
        @total_wins_by_season[game["season"]] += 0
      elsif passed_id == game["home_team_id"] && game["home_goals"] < game["away_goals"]
        @total_wins_by_season[game["season"]] += 0
      end
    end
  end

  def win_percentage_by_season_by_team_id
    @win_percentage_by_season = Hash.new
    @total_wins_by_season.each do |season, total_win|
      @win_percentage_by_season[season] = (total_win.to_f / @total_games_by_season[season]).round(2)
    end
  end

  def best_and_worst_season_suite(passed_id)
    collect_game_objects_by_team_id(passed_id)
    total_games_by_season_by_team_id
    total_wins_by_season_by_team_id(passed_id)
    win_percentage_by_season_by_team_id
  end

  def best_season(passed_id)
    best_and_worst_season_suite(passed_id)
    @win_percentage_by_season.invert.max[1]
  end

  def worst_season(passed_id)
    best_and_worst_season_suite(passed_id)
    @win_percentage_by_season.invert.min[1]
  end

  def sort_games_won_by_team_id(passed_id)
    @games_won_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_team_id_game_objects.each do |game|
      if passed_id == game["away_team_id"] && game["away_goals"] > game["home_goals"]
        @games_won_by_team_id[game["away_team_id"]] += 1
      elsif passed_id == game["home_team_id"] && game["home_goals"] > game["away_goals"]
        @games_won_by_team_id[game["home_team_id"]] += 1
      elsif passed_id == game["away_team_id"] && game["away_goals"] < game["home_goals"]
        @games_won_by_team_id[game["away_team_id"]] += 0
      elsif passed_id == game["home_team_id"] && game["home_goals"] < game["away_goals"]
        @games_won_by_team_id[game["home_team_id"]] += 0
      end
    end
  end

  def average_win_suite(passed_id)
    collect_game_objects_by_team_id(passed_id)
    @total_games_played = @by_team_id_game_objects.size
    sort_games_won_by_team_id(passed_id)
    @games_won_by_team = @games_won_by_team_id.values[0].to_f
  end

  def average_win_percentage(passed_id)
    average_win_suite(passed_id)
    (@games_won_by_team / @total_games_played).round(2)
  end

  def goals_by_game_by_team(passed_id)
    @goals_by_game = []
    @by_team_id_game_objects.each do |game|
      if passed_id == game["away_team_id"]
        @goals_by_game << game["away_goals"]
      elsif passed_id == game["home_team_id"]
        @goals_by_game << game["home_goals"]
      end
    end
  end

  def most_goals_scored(passed_id)
    collect_game_objects_by_team_id(passed_id)
    goals_by_game_by_team(passed_id)
    @goals_by_game.max.to_i
  end

  def fewest_goals_scored(passed_id)
    collect_game_objects_by_team_id(passed_id)
    goals_by_game_by_team(passed_id)
    @goals_by_game.min.to_i
  end

  def games_played_by_opponent_by_team(passed_id)
    @games_played_by_opponent = Hash.new{ |hash, key| hash[key] = 0 }
    @by_team_id_game_objects.each do |game|
      if passed_id == game["away_team_id"]
        @games_played_by_opponent[game["home_team_id"]] += 1
      elsif passed_id == game["home_team_id"]
        @games_played_by_opponent[game["away_team_id"]] += 1
      end
    end
  end

  def games_won_by_opponent_by_team(passed_id)
    @games_won_by_opponent = Hash.new{ |hash, key| hash[key] = 0 }
    @by_team_id_game_objects.each do |game|
      if passed_id == game["away_team_id"] && game["away_goals"] > game["home_goals"]
        @games_won_by_opponent[game["home_team_id"]] += 1
      elsif passed_id == game["home_team_id"] && game["home_goals"] > game["away_goals"]
        @games_won_by_opponent[game["away_team_id"]] += 1
      elsif passed_id == game["away_team_id"] && game["away_goals"] < game["home_goals"]
        @games_won_by_opponent[game["home_team_id"]] += 0
      elsif passed_id == game["home_team_id"] && game["home_goals"] < game["away_goals"]
        @games_won_by_opponent[game["away_team_id"]] += 0
      end
    end
  end

  def win_ratio_by_opponent_by_team
    @win_ratio_by_opponent = Hash.new
    @games_won_by_opponent.each do |opponent, wins_against_opp|
      @win_ratio_by_opponent[opponent] = (wins_against_opp.to_f / @games_played_by_opponent[opponent]).round(2)
    end
  end

  def fav_opponent_and_rival_suite(passed_id)
    collect_game_objects_by_team_id(passed_id)
    games_played_by_opponent_by_team(passed_id)
    games_won_by_opponent_by_team(passed_id)
    win_ratio_by_opponent_by_team
  end

  def favorite_opponent(passed_id)
    fav_opponent_and_rival_suite(passed_id)
    fav_opp = @win_ratio_by_opponent.invert.max[1]
    @team_name_by_id[fav_opp]
  end

  def rival(passed_id)
    fav_opponent_and_rival_suite(passed_id)
    rival = @win_ratio_by_opponent.invert.min[1]
    @team_name_by_id[rival]
  end
end
