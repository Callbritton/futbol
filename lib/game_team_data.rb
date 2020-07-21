class GameTeamData
  attr_reader :game_id, :team_id, :hoa, :result,
  :settled_in, :head_coach, :goals, :shots, :tackles,
  :pim, :powerPlayOpportunities, :powerPlayGoals,
  :faceOffWinPercentage, :giveaways, :takeaways

  def initialize()
    @game_id = game_id
    @team_id = team_id
    @hoa = hoa
    @result = result
    @settled_in = settled_in
    @head_coach = head_coach
    @goals = goals
    @shots = shots
    @tackles = tackles
    @pim = pim
    @powerPlayOpportunities = powerPlayOpportunities
    @powerPlayGoals = powerPlayGoals
    @faceOffWinPercentage = faceOffWinPercentage
    @giveaways = giveaways
    @takeaways = takeaways
  end

  def create_attributes(table, line_index)
    index = 0
      @game_id = table[line_index][index]
      index += 1
      @team_id = table[line_index][index]
      index += 1
      @hoa = table[line_index][index]
      index += 1
      @result = table[line_index][index]
      index += 1
      @settled_in = table[line_index][index]
      index += 1
      @head_coach = table[line_index][index]
      index += 1
      @goals = table[line_index][index]
      index += 1
      @shots = table[line_index][index]
      index += 1
      @tackles = table[line_index][index]
      index += 1
      @pim = table[line_index][index]
      index += 1
      @powerPlayOpportunities = table[line_index][index]
      index += 1
      @powerPlayGoals = table[line_index][index]
      index += 1
      @faceOffWinPercentage = table[line_index][index]
      index += 1
      @giveaways = table[line_index][index]
      index += 1
      @takeaways = table[line_index][index]
  end

end
