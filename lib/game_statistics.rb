require_relative "futbol_data"
require_relative "futbol_creatable"
include FutbolCreatable

class GameStatistics < FutbolData

  attr_reader :all_games

  def initialize
    @all_games = FutbolCreatable.object_creation("games")
    @total_games = @all_games.size
    @total_goals_per_season = Hash.new{ |hash, key| hash[key] = 0 }
  end

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
end
