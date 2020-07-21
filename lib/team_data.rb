class TeamData
  attr_reader :team_id, :franchiseId, :teamName, :abbreviation,
  :stadium, :link

  def initialize()
    @team_id = team_id
    @franchiseId = franchiseId
    @teamName = teamName
    @abbreviation = abbreviation
    @stadium = stadium
    @link = link
  end

  def create_attributes(table, line_index)
    index = 0
      @team_id = table[line_index][index]
      index += 1
      @franchiseId = table[line_index][index]
      index += 1
      @teamName = table[line_index][index]
      index += 1
      @abbreviation = table[line_index][index]
      index += 1
      @stadium = table[line_index][index]
      index += 1
      @link = table[line_index][index]
  end

end
