class TeamData
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize()
    @team_id      = nil
    @franchise_id  = nil
    @team_name     = nil
    @abbreviation = nil
    @stadium      = nil
    @link         = nil
  end

  def self.create_objects
    table = CSV.parse(File.read('./data/dummy_file_teams.csv'), headers: true)
    line_index = 0
    all_teams = []
    table.size.times do
      team_data = TeamData.new
      team_data.create_attributes(table, line_index)
      all_teams << team_data
      line_index += 1
    end
    all_teams
  end

  def create_attributes(table, line_index)
    @team_id      = table[line_index]["team_id"]
    @franchise_id  = table[line_index]["franchiseId"]
    @team_name     = table[line_index]["teamName"]
    @abbreviation = table[line_index]["abbreviation"]
    @stadium      = table[line_index]["Stadium"]
    @link         = table[line_index]["link"]
  end
end
