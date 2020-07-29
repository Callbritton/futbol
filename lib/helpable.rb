module Helpable

  def get_team_name_by_id
    @team_name_by_id = Hash.new{}
    @all_teams.each do |team|
      @team_name_by_id[team["team_id"]] = team["teamName"]
    end
    @team_name_by_id
  end

  def team_data_object_creation
    @total_wins_by_season = Hash.new{ |hash, key| hash[key] = 0 }
    @total_games_by_season = Hash.new{ |hash, key| hash[key] = 0 }
    @win_ratio_by_opponent = Hash.new
    @win_percentage_by_season = Hash.new
    @games_won_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @games_played_by_opponent = Hash.new{ |hash, key| hash[key] = 0 }
    @games_won_by_opponent = Hash.new{ |hash, key| hash[key] = 0 }
  end

  def total_games_by_season_by_team_id
    @by_team_id_game_objects.each do |game|
      @total_games_by_season[game["season"]] += 1
    end
  end

  def win_ratio_by_opponent_by_team
    @games_won_by_opponent.each do |opponent, wins_against_opp|
      @win_ratio_by_opponent[opponent] = (wins_against_opp.to_f / @games_played_by_opponent[opponent]).round(3)
    end
  end

  def win_percentage_by_season_by_team_id
    @total_wins_by_season.each do |season, total_win|
      @win_percentage_by_season[season] = (total_win.to_f / @total_games_by_season[season]).round(2)
    end
  end

end
