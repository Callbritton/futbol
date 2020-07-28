require_relative "game_data"
class GameStatistics

  def initialize
    @all_games = all_games_creation
    @game_outcomes = {
      :home_games_won => 0,
      :visitor_games_won => 0,
      :ties => 0
    }
    @total_games = @all_games.size
    @games_per_season = Hash.new{ |hash, key| hash[key] = 0 }
    @total_goals_per_season = Hash.new{ |hash, key| hash[key] = 0 }
    @average_goals_per_season = Hash.new
    total_goals_per_season
    win_data
  end

  def all_games_creation
    GameData.create_objects
  end

  def total_score
    @all_games.map do |games|
      games.home_goals.to_i + games.away_goals.to_i
    end
  end

  def highest_total_score
    total_score.max
  end

  def lowest_total_score
    total_score.min
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
      @games_per_season[game.season] += 1
    end
    @games_per_season
  end

  def average_goals_per_game
    decimal_average = total_score.sum.to_f / @total_games
    decimal_average.round(2)
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

  def average_goals_by_season
    count_of_games_by_season
    @total_goals_per_season.each do |season, goals|
      average = goals.to_f / @games_per_season[season]
      @average_goals_per_season[season] = average.round(2)
    end
    @average_goals_per_season
  end
end
