require "minitest/autorun"
require "minitest/pride"
require "./lib/league_statistics"
require 'mocha/minitest'

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

  def test_find_best_
    assert_equal "Reign FC", @league_statistics.best_offense

    def test_worst_offense
      assert_equal "Utah Royals FC", @league_statistics.worst_offense
    end
  end

  def test_can_get_team_name_by_id
    # expected = {"1"=>"Atlanta United", "4"=>"Chicago Fire", "26"=>"FC Cincinnati", "14"=>"DC United", "6"=>"FC Dallas", "3"=>"Houston Dynamo", "5"=>"Sporting Kansas City", "17"=>"LA Galaxy", "28"=>"Los Angeles FC", "18"=>"Minnesota United FC", "23"=>"Montreal Impact", "16"=>"New England Revolution", "9"=>"New York City FC", "8"=>"New York Red Bulls", "30"=>"Orlando City SC", "15"=>"Portland Timbers", "19"=>"Philadelphia Union", "24"=>"Real Salt Lake", "27"=>"San Jose Earthquakes", "2"=>"Seattle Sounders FC", "20"=>"Toronto FC", "21"=>"Vancouver Whitecaps FC", "25"=>"Chicago Red Stars", "13"=>"Houston Dash", "10"=>"North Carolina Courage", "29"=>"Orlando Pride", "52"=>"Portland Thorns FC", "54"=>"Reign FC", "12"=>"Sky Blue FC", "7"=>"Utah Royals FC", "22"=>"Washington Spirit FC", "53"=>"Columbus Crew SC"}
    assert_equal "Sporting Kansas City", @league_statistics.get_team_name_by_id["5"]
  end

  def test_goals_by_id
      # expected = {"3"=>1129, "6"=>1154, "5"=>1262, "17"=>1007, "16"=>1156, "9"=>1038, "8"=>1019, "30"=>1062, "26"=>1065, "19"=>1068, "24"=>1146, "2"=>1053, "15"=>1168, "20"=>978, "14"=>1159, "28"=>1128, "4"=>972, "21"=>973, "25"=>1061, "13"=>955, "18"=>1101, "10"=>1007, "29"=>1029, "52"=>1041, "54"=>239, "1"=>896, "23"=>923, "12"=>936, "27"=>263, "7"=>841, "22"=>964, "53"=>620}
      assert_equal 1038, @league_statistics.goals_by_id["9"]
  end

  def test_games_by_id
    # expected = {"3"=>531, "6"=>510, "5"=>552, "17"=>489, "16"=>534, "9"=>493, "8"=>498, "30"=>502, "26"=>511, "19"=>507, "24"=>522, "2"=>482, "15"=>528, "20"=>473, "14"=>522, "28"=>516, "4"=>477, "21"=>471, "25"=>477, "13"=>464, "18"=>513, "10"=>478, "29"=>475, "52"=>479, "54"=>102, "1"=>463, "23"=>468, "12"=>458, "27"=>130, "7"=>458, "22"=>471, "53"=>328}
    assert_equal 489, @league_statistics.games_by_id["17"]
  end

  def test_average_goals_by_id
    # expected = {"3"=>2.13, "6"=>2.26, "5"=>2.29, "17"=>2.06, "16"=>2.16, "9"=>2.11, "8"=>2.05, "30"=>2.12, "26"=>2.08, "19"=>2.11, "24"=>2.2, "2"=>2.18, "15"=>2.21, "20"=>2.07, "14"=>2.22, "28"=>2.19, "4"=>2.04, "21"=>2.07, "25"=>2.22, "13"=>2.06, "18"=>2.15, "10"=>2.11, "29"=>2.17, "52"=>2.17, "54"=>2.34, "1"=>1.94, "23"=>1.97, "12"=>2.04, "27"=>2.02, "7"=>1.84, "22"=>2.05, "53"=>1.89}
    assert_equal 2.16, @league_statistics.average_goals_by_id["16"]
  end

  def test_goals_by_away_id
    # expected = {"3"=>572, "6"=>568, "5"=>598, "17"=>504, "16"=>558, "9"=>498, "8"=>500, "30"=>506, "26"=>519, "19"=>519, "24"=>553, "2"=>507, "15"=>582, "20"=>458, "14"=>550, "28"=>549, "4"=>470, "21"=>450, "25"=>505, "13"=>453, "18"=>527, "10"=>469, "29"=>505, "52"=>488, "54"=>107, "1"=>440, "12"=>462, "23"=>453, "22"=>479, "7"=>430, "27"=>120, "53"=>303}
    assert_equal 558, @league_statistics.goals_by_away_id["16"]
  end

  def test_test_goals_by_home_id
    # expected = {"6"=>586, "3"=>557, "5"=>664, "16"=>598, "17"=>503, "8"=>519, "9"=>540, "30"=>556, "19"=>549, "26"=>546, "24"=>593, "2"=>546, "15"=>586, "20"=>520, "14"=>609, "28"=>579, "4"=>502, "21"=>523, "25"=>556, "13"=>502, "18"=>574, "10"=>538, "29"=>524, "52"=>553, "54"=>132, "1"=>456, "23"=>470, "27"=>143, "7"=>411, "22"=>485, "12"=>474, "53"=>317}
    assert_equal 664, @league_statistics.goals_by_home_id["5"]
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
