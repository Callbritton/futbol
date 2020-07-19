require 'pry'
class GameStatistics

  def initialize(games_hash)
    @games_hash = games_hash
  end

  def data_size
    @games_hash["game_id"].size
  end

  def total_goals
    index = 0
    total_goals_by_game = []
    data_size.times do
      total_goals_by_game << @games_hash["away_goals"][index].to_i + @games_hash["home_goals"][index].to_i
      index += 1
    end
    total_goals_by_game
  end

  def highest_total_score
    total_goals.max
  end

  def lowest_total_score
    total_goals.min
  end

  def count_games_by_season
    games_by_season = {}
    @games_hash["season"].each do |season|
      if games_by_season[season] == nil
        games_by_season[season] = 1
      else
        games_by_season[season] += 1
      end
    end
    games_by_season
  end

# Definitely needs refactored
  def average_goals_by_season
    goals_by_season = {}
    index = 0
    @games_hash["season"].each do |season|
      if goals_by_season[season] == nil
        goals_by_season[season] = [@games_hash["away_goals"][index].to_i + @games_hash["home_goals"][index].to_i]
      else
        goals_by_season[season] += [@games_hash["away_goals"][index].to_i + @games_hash["home_goals"][index].to_i]
      end
      index += 1
    end
    goals_by_season.keys.each do |season|
      goals_by_season[season] = (goals_by_season[season].sum.to_f / goals_by_season[season].size).round(2)
    end
    goals_by_season
  end

  def calculate_average_for_season

  end
end
