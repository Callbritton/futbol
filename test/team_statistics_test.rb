require "./test/test_helper"

class TeamStatisticsTest < Minitest::Test

  def setup
    @team_stats = TeamStatistics.new
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_stats
  end

  def test_it_can_create_team_hash_details
    expected = {"team_id"=>"3", "franchise_id"=>"10", "team_name"=>"Houston Dynamo", "abbreviation"=>"HOU", "link"=>"/api/v1/teams/3"}
    assert_equal expected, @team_stats.team_info("3")
  end

  def test_it_can_return_best_season_by_team_id
    assert_equal "20132014", @team_stats.best_season("6")
  end

  def test_it_can_return_worst_season_by_team_id
    assert_equal "20142015", @team_stats.worst_season("6")
  end

  def test_it_can_calc_win_percentage_by_team_id
    assert_equal 0.49, @team_stats.average_win_percentage("6")
  end

  def test_it_can_print_mostgoals_scored_by_team_id
    assert_equal 7, @team_stats.most_goals_scored("18")
  end

  def test_it_can_print_fewest_goals_scored_by_team_id
    assert_equal 0, @team_stats.fewest_goals_scored("18")
  end

  def test_it_can_return_favorite_opponent_by_team
    assert_equal "DC United", @team_stats.favorite_opponent("18")
  end

  def test_it_can_return_rival_by_team
    assert_equal "Houston Dash", @team_stats.rival("18")
  end
end
