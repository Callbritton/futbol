require_relative "futbol_data"
require_relative "futbol_creatable"
require_relative "helpable"
include Helpable
include FutbolCreatable

class TeamStatistics < FutbolData

  def initialize
    @all_games       = FutbolCreatable.object_creation("games")
    @all_teams       = FutbolCreatable.object_creation("teams")
    @all_game_teams  = FutbolCreatable.object_creation("game_teams")
    get_team_name_by_id
    team_data_object_creation
  end

  def total_wins_by_season_by_team_id(passed_id)
    @by_team_id_game_objects.each do |game|
      if helper_for_win_count(passed_id, game)
        @total_wins_by_season[game["season"]] += 1
      elsif helper_for_loss_count(passed_id, game)
        @total_wins_by_season[game["season"]] += 0
      end
    end
  end

  def helper_for_win_count(passed_id, game)
    (passed_id == game["away_team_id"] && game["away_goals"] > game["home_goals"]) ||
    (passed_id == game["home_team_id"] && game["home_goals"] > game["away_goals"])
  end

  def helper_for_loss_count(passed_id, game)
    (passed_id == game["away_team_id"] && game["away_goals"] < game["home_goals"]) ||
    (passed_id == game["home_team_id"] && game["home_goals"] < game["away_goals"])
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
    @by_team_id_game_objects.each do |game|
      if passed_id == game["away_team_id"] && game["away_goals"] > game["home_goals"]
        @games_won_by_team_id[game["away_team_id"]] += 1
      elsif passed_id == game["home_team_id"] && game["home_goals"] > game["away_goals"]
        @games_won_by_team_id[game["home_team_id"]] += 1
      elsif helper_for_loss_count(passed_id, game)
        helper_counter_for_loss(game)
      end
    end
  end

  def helper_counter_for_loss(game)
    @games_won_by_team_id[game["away_team_id"]] += 0
    @games_won_by_team_id[game["home_team_id"]] += 0
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
    @by_team_id_game_objects.each do |game|
      if passed_id == game["away_team_id"]
        @games_played_by_opponent[game["home_team_id"]] += 1
      elsif passed_id == game["home_team_id"]
        @games_played_by_opponent[game["away_team_id"]] += 1
      end
    end
  end

  def games_won_by_opponent_by_team(passed_id)
    @by_team_id_game_objects.each do |game|
      if passed_id == game["away_team_id"] && game["away_goals"] > game["home_goals"]
        @games_won_by_opponent[game["home_team_id"]] += 1
      elsif passed_id == game["home_team_id"] && game["home_goals"] > game["away_goals"]
        @games_won_by_opponent[game["away_team_id"]] += 1
      end
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
