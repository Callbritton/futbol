module FutbolCreatable

  def object_creation(data_type)
    if data_type == "games"
      FutbolData.new(data_type).games
    elsif data_type == "teams"
      FutbolData.new(data_type).teams
    elsif data_type == "game_teams"
      FutbolData.new(data_type).game_teams
    end
  end
end
