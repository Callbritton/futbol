class GameData
  attr_reader :game_id, :season, :type,
    :date_time, :away_team_id, :home_team_id,
    :away_goals, :home_goals, :venue, :venue_link

  def initialize()
    @game_id = game_id
    @season = season
    @type = type
    @date_time = date_time
    @away_team_id = away_team_id
    @home_team_id = home_team_id
    @away_goals = away_goals
    @home_goals = home_goals
    @venue = venue
    @venue_link = venue_link
  end

  def create_attributes(table, line_index)
    index = 0
      @game_id = table[line_index][index]
      index += 1
      @season = table[line_index][index]
      index += 1
      @type = table[line_index][index]
      index += 1
      @date_time = table[line_index][index]
      index += 1
      @away_team_id = table[line_index][index]
      index += 1
      @home_team_id = table[line_index][index]
      index += 1
      @away_goals = table[line_index][index]
      index += 1
      @home_goals = table[line_index][index]
      index += 1
      @venue = table[line_index][index]
      index += 1
      @venue_link = table[line_index][index]
  end

end
