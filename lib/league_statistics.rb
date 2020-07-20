class LeagueStatistics

  attr_reader :game_hash, :team_hash

  def initialize(game_hash, team_hash)
    @game_hash = game_hash
    @team_hash = team_hash
  end
end
