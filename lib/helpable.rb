module Helpable

  def get_team_name_by_id
    @team_name_by_id = Hash.new{}
    @all_teams.each do |team|
      @team_name_by_id[team["team_id"]] = team["teamName"]
    end
    @team_name_by_id
  end

end
