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
  end

  def total_games_by_coach_by_season
    @total_games_by_coach = Hash.new{ |hash, key| hash[key] = 0}
    @by_season_game_team_objects.each do |game_by_season|
      @total_games_by_coach[game_by_season["head_coach"]] += 1
    end
  end

  def total_wins_by_coach_by_season
    @total_wins_by_coach = Hash.new{ |hash, key| hash[key] = 0}
    @by_season_game_team_objects.each do |game_by_season|
      if game_by_season["result"] == "WIN"
        @total_wins_by_coach[game_by_season["head_coach"]] += 1
      end
    end
  end

  def win_percentage_by_coach_by_season
    @win_percentage_by_coach = {}
    @total_games_by_coach.each do |coach, total_games|
      @win_percentage_by_coach[coach] = (@total_wins_by_coach[coach].to_f / total_games).round(3)
    end
  end

  def winningest_and_worst_suite(season)
    collect_game_team_objects_by_season(season)
    create_coach_by_team_id(season)
    total_games_by_coach_by_season
    total_wins_by_coach_by_season
    win_percentage_by_coach_by_season
  end

  def winningest_coach(season)
    winningest_and_worst_suite(season)
    @win_percentage_by_coach.invert.max[1]
  end

  def worst_coach(season)
    winningest_and_worst_suite(season)
    @win_percentage_by_coach.invert.min[1]
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
