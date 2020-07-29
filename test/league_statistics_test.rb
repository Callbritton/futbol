require "./test/test_helper"

class LeagueStatisticTest < Minitest::Test

  def setup
    @league_statistics = LeagueStatistics.new
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_it_can_count_teams
    assert_equal 32, @league_statistics.count_of_teams
  end

  def test_find_best_offense
    assert_equal "Reign FC", @league_statistics.best_offense
  end

  def test_worst_offense
    assert_equal "Utah Royals FC", @league_statistics.worst_offense
  end

  def test_can_get_team_name_by_id
    assert_equal "Sporting Kansas City", @league_statistics.get_team_name_by_id["5"]
  end

  def test_goals_by_id
      assert_equal 1038, @league_statistics.goals_by_id["9"]
  end

  def test_games_by_id
    assert_equal 489, @league_statistics.games_by_id["17"]
  end

  def test_average_goals_by_id
    assert_equal 2.16, @league_statistics.average_goals_by_id["16"]
  end

  def test_goals_by_away_id
    assert_equal 558, @league_statistics.goals_by_away_id["16"]
  end

  def test_test_goals_by_home_id
    assert_equal 664, @league_statistics.goals_by_home_id["5"]
  end

  def test_it_can_calc_average_score_away
    @league_statistics.stubs(:average_score_per_away_game_by_team_id).returns("Hash of avg away scores")
    assert_equal "Hash of avg away scores", @league_statistics.average_score_per_away_game_by_team_id
  end

  def test_it_can_calc_average_score_home
    @league_statistics.stubs(:average_score_per_home_game_by_team_id).returns("Hash of avg home scores")
    assert_equal "Hash of avg home scores", @league_statistics.average_score_per_home_game_by_team_id
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @league_statistics.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @league_statistics.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Reign FC", @league_statistics.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @league_statistics.lowest_scoring_home_team
  end

end
