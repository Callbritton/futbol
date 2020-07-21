class LeagueStatistics

  attr_reader :all_data

  def initialize(all_data)
    @all_data = all_data
  end

  # def highest_average_scoring_visitor
  # end

  # def pull_goals_by_team_id(info, key)
  #   hash_creation_by_index(info, key).each do |team_id, value|
  #     goals = value.reduce({}) do |goals, index|
  #       goal = @game_hash["away_goals"][index]
  #       goals.merge(team_id => goal)
  #     end
  #     require "pry"; binding.pry
  #     goals
  #   end
  # end
  #
  # def hash_creation_by_index(info, key)
  #   any_id_hash_by_index = info[key].each_with_index.group_by(&:first).inject({}) do |result, (away_id, indeces)|
  #     next result if indeces.length == 1
  #     result.merge away_id => indeces.map {|pair| pair[1]}
  #   end
  #   any_id_hash_by_index
  # end

  def best_offense
    team_id = 3
    total_goals_by_id = []
    while team_id < @all_data.size
      x = @all_data.find_all do |game|
        game.away_team_id == team_id.to_s || game.home_team_id == team_id.to_s
      end
        # total_goals_by_id << game.away_goals
        # total_goals_by_id << game.home_goals
    team_id += 1
    require "pry"; binding.pry
    end
  end
end
