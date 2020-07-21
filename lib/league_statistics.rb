class LeagueStatistics

  attr_reader :game_hash, :team_hash

  def initialize(game_hash, team_hash)
    @game_hash = game_hash
    @team_hash = team_hash
  end

  # def highest_average_scoring_visitor
  # end

  def hash_creation_by_index(info, key)
    any_id_hash_by_index = info[key].each_with_index.group_by(&:first).inject({}) do |result, (away_id, indeces)|
      next result if indeces.length == 1
      result.merge away_id => indeces.map {|pair| pair[1]}
    end
    any_id_hash_by_index
  end

  def pull_goals_by_index
    
  end
end
