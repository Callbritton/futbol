require_relative "futbol_data"
require_relative "futbol_creatable"
include FutbolCreatable
require_relative "helpable"
include Helpable

class SeasonStatistics < FutbolData

  def initialize
    @all_games       = FutbolCreatable.object_creation("games")
    @all_teams       = FutbolCreatable.object_creation("teams")
    @all_game_teams  = FutbolCreatable.object_creation("game_teams")
    get_team_name_by_id
    @by_season_game_objects = []
    @counter_wins_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
  end

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
    winningest_coach = @coach_by_team_id[max_team_id]
  end

  def worst_coach(season)
    winningest_and_worst_suite(season)
    min_team_id = @win_percentage.invert.min[1]
    worst_coach = @coach_by_team_id[min_team_id]
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
end
