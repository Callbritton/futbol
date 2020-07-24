require "minitest/autorun"
require "minitest/pride"
require "./lib/league_statistics"
require "./lib/team_data"
require "./lib/game_team_data"
require 'csv'

class LeagueStatisticTest < Minitest::Test

  def setup
    @league_statistics = LeagueStatistics.new
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end

  def test_it_can_count_teams
    assert_equal 19, @league_statistics.count_of_teams
  end

  def test_find_best_and_worst_offense
    assert_equal "FC Dallas", @league_statistics.best_offense
    assert_equal "Sporting Kansas City", @league_statistics.worst_offense
  end

  def test_can_get_team_name_by_id
    expected = {
                1=>"Atlanta United", 
                4=>"Chicago Fire",
                26=>"FC Cincinnati",
                14=>"DC United",
                6=>"FC Dallas",
                3=>"Houston Dynamo",
                5=>"Sporting Kansas City",
                17=>"LA Galaxy",
                28=>"Los Angeles FC",
                18=>"Minnesota United FC",
                23=>"Montreal Impact",
                16=>"New England Revolution",
                9=>"New York City FC",
                8=>"New York Red Bulls",
                30=>"Orlando City SC",
                15=>"Portland Timbers",
                19=>"Philadelphia Union",
                24=>"Real Salt Lake",
                27=>"San Jose Earthquakes"
              }
    assert_equal expected, @league_statistics.get_team_name_by_id
  end

end
