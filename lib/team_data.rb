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

  def create_attributes(table, line_index)
    index = 0
      @team_id = table[line_index][index]
      index += 1
      @franchise_id = table[line_index][index]
      index += 1
      @team_name = table[line_index][index]
      index += 1
      @abbreviation = table[line_index][index]
      index += 1
      @stadium = table[line_index][index]
      index += 1
      @link = table[line_index][index]
  end

end
