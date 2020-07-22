class LeagueStatistics

  attr_reader :game_data, :team_data, :game_team_data

  def initialize(game_data, team_data, game_team_data)
    @game_data = game_data
    @team_data = team_data
    @game_team_data = game_team_data
  end

  def obtain_goals_per_game_by_team_id
    team_id_num = 0
    hash = {}
    while team_id_num <= @game_team_data.size
      @game_team_data.each do |game|
        if team_id_num == game.team_id && hash[team_id_num] == nil
          hash[team_id_num] = [game.goals]
        elsif team_id_num == game.team_id
          hash[team_id_num] << game.goals
        end
      end
      team_id_num += 1
    end
    hash
  end

  def obtain_goals_per_game_by_away_team_id
    team_id_num = 0
    hash = {}
    while team_id_num <= @game_team_data.size
      @game_team_data.each do |game|
        if team_id_num == game.team_id && hash[team_id_num] == nil && game.hoa == "away"
          hash[team_id_num] = [game.goals]
        elsif team_id_num == game.team_id && game.hoa == "away"
          hash[team_id_num] << game.goals
        end
      end
      team_id_num += 1
    end
    hash
  end

  def highest_scoring_home_team
    goals_per_home_game = obtain_goals_per_game_by_team_id
    goals_per_home_game.each do |goals|
      goals_per_home_game[goals[0]] = (goals[1].sum / goals[1].size.to_f).round(2)
    end
    convert_team_id_to_name(goals_per_home_game.invert.max[1])
  end

  def lowest_scoring_home_team
    goals_per_home_game = obtain_goals_per_game_by_team_id
    goals_per_home_game.each do |goals|
      goals_per_home_game[goals[0]] = (goals[1].sum / goals[1].size.to_f).round(2)
    end
    convert_team_id_to_name(goals_per_home_game.invert.min[1])
  end

  def highest_scoring_visitor
    goals_per_away_game = obtain_goals_per_game_by_team_id
    goals_per_away_game.each do |goals|
      goals_per_away_game[goals[0]] = (goals[1].sum / goals[1].size.to_f).round(2)
    end
    convert_team_id_to_name(goals_per_away_game.invert.max[1])
  end

  def lowest_scoring_visitor
    goals_per_away_game = obtain_goals_per_game_by_team_id
    goals_per_away_game.each do |goals|
      goals_per_away_game[goals[0]] = (goals[1].sum / goals[1].size.to_f).round(2)
    end
    convert_team_id_to_name(goals_per_away_game.invert.min[1])
  end

  def convert_team_id_to_name(team_id_num)
    the_team = ''
    @team_data.each do |team|
      if team.team_id == team_id_num
        the_team = team.team_name
      end
    end
    the_team
  end

  def best_offense
    goals_per_game = obtain_goals_per_game_by_team_id
    goals_per_game.each do |goals|
      goals_per_game[goals[0]] = (goals[1].sum / goals[1].size.to_f).round(2)
    end
    convert_team_id_to_name(goals_per_game.invert.max[1])
  end

  def worst_offense
    goals_per_game = obtain_goals_per_game_by_team_id
    goals_per_game.each do |goals|
      goals_per_game[goals[0]] = (goals[1].sum / goals[1].size.to_f).round(2)
    end
    convert_team_id_to_name(goals_per_game.invert.min[1])
  end
end
