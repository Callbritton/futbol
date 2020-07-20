class LeagueStatistics

  attr_reader :game_hash, :team_hash

  def initialize(game_hash, team_hash)
    @game_hash = game_hash
    @team_hash = team_hash
  end

  def highest_average_scoring_visitor
    @game_hash["away_team_id"].each_with_index.group_by(&:first).inject({}) do |result, (away_id, indeces)|
      next result if indeces.length == 1
      result.merge away_id => indeces.map {|pair| pair[1]}
    end
  end
end
