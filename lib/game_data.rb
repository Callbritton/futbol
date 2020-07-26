class GameData

  attr_reader :game_id, :season, :type,
      :date_time, :away_team_id, :home_team_id,
      :away_goals, :home_goals, :venue, :venue_link

    def initialize()
      @game_id = nil
      @season = nil
      @type = nil
      @date_time = nil
      @away_team_id = nil
      @home_team_id = nil
      @away_goals = nil
      @home_goals = nil
      @venue = nil
      @venue_link = nil
    end

    def self.create_objects
      table = CSV.parse(File.read('./data/games.csv'), headers: true)
      line_index = 0
      all_games = []
      table.size.times do
        game_data = GameData.new
        game_data.create_attributes(table, line_index)
        all_games << game_data
        line_index += 1
      end
      all_games
    end

    def create_attributes(table, line_index)
      @game_id = table[line_index]["game_id"]
      @season = table[line_index]["season"]
      @type = table[line_index]["type"]
      @date_time = table[line_index]["date_time"]
      @away_team_id = table[line_index]["away_team_id"]
      @home_team_id = table[line_index]["home_team_id"]
      @away_goals = table[line_index]["away_goals"]
      @home_goals = table[line_index]["home_goals"]
      @venue = table[line_index]["venue"]
      @venue_link = table[line_index]["venue_link"]
    end
end
