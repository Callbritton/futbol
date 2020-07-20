class LeagueStatistics

  attr_reader :game_hash, :team_hash

  def initialize(game_hash, team_hash)
    @game_hash = game_hash
    @team_hash = team_hash
  end

  def team_data_size
    @team_hash["team_id"].size
  end

  def teams_count

  end
end
