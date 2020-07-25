require "minitest/autorun"
require "minitest/pride"
require "./lib/season_statistics"
require "csv"

class SeasonStatisticsTest < Minitest::Test

  def setup
    @season_statistics = SeasonStatistics.new
  end

  def test_it_exists

    assert_instance_of SeasonStatistics, @season_statistics
  end

  def test_get_coach_by_team_id
    expected = {
                3=>"John Tortorella",
                6=>"Claude Julien",
                5=>"Dan Bylsma",
                17=>"Mike Babcock"
              }

    assert_equal expected, @season_statistics.get_coach_by_team_id
  end

  def test_get_team_name_by_team_id
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

    assert_equal expected, @season_statistics.get_team_name_by_team_id
  end

  def test_get_total_wins_by_team_id
    expected = {
                6=>9,
                16=>3,
                17=>4,
                8=>1,
                9=>1
              }


    assert_equal expected, @season_statistics.get_total_wins_by_team_id
  end

  def test_get_tackles_by_team_id
    expected = {
                3=>179,
                6=>271,
                5=>150,
                17=>43
              }

    assert_equal expected, @season_statistics.get_tackles_by_team_id
  end
end
