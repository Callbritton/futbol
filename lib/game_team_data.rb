class GameTeamData
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :power_play_opportunites,
              :power_play_goals,
              :face_off_win_percentage,
              :giveaways,
              :takeaways

  def initialize()
    @game_id                 = nil
    @team_id                 = nil
    @hoa                     = nil
    @result                  = nil
    @settled_in              = nil
    @head_coach              = nil
    @goals                   = nil
    @shots                   = nil
    @tackles                 = nil
    @pim                     = nil
    @power_play_opportunites = nil
    @power_play_goals        = nil
    @face_off_win_percentage = nil
    @giveaways               = nil
    @takeaways               = nil
  end

  def self.create_objects
    table = CSV.parse(File.read('./data/dummy_file_game_teams.csv'), headers: true)
    line_index = 0
    all_game_teams = []
    table.size.times do
      game_team_data = GameTeamData.new
      game_team_data.create_attributes(table, line_index)
      all_game_teams << game_team_data
      line_index += 1
    end
    all_game_teams
  end

  def create_attributes(table, line_index)
    @game_id = table[line_index]["game_id"]
    @team_id = table[line_index]["team_id"]
    @hoa = table[line_index]["HoA"]
    @result = table[line_index]["result"]
    @settled_in = table[line_index]["settled_in"]
    @head_coach = table[line_index]["head_coach"]
    @goals = table[line_index]["goals"]
    @shots = table[line_index]["shots"]
    @tackles = table[line_index]["tackles"]
    @pim = table[line_index]["pim"]
    @power_play_opportunites = table[line_index]["powerPlayOpportunities"]
    @power_play_goals = table[line_index]["powerPlayGoals"]
    @face_off_win_percentage = table[line_index]["faceOffWinPercentage"]
    @giveaways = table[line_index]["giveaways"]
    @takeaways = table[line_index]["takeaways"]

  end
end
