class TeamData

  attr_reader :team_id, :franchise_id, :team_name, :abbreviation,
  :stadium, :link

  def initialize()
    @team_id = team_id
    @franchise_id = franchise_id
    @team_name = team_name
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end

  def create_attributes

  end
end
