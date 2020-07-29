# require "minitest/autorun"
# require "minitest/pride"
# require "./lib/stat_tracker"
# require 'csv'
#
# class StatTrackerTest < Minitest::Test
#
#   def setup
#     game_path = './data/dummy_file_games.csv'
#     team_path = './data/dummy_file_teams.csv'
#     game_teams_path = './data/dummy_file_game_teams.csv'
#
#     @locations = {
#       games: game_path,
#       teams: team_path,
#       game_teams: game_teams_path
#     }
#   end
#
#   def test_it_exists
#     stat_tracker = StatTracker.new(@locations)
#
#     assert_instance_of StatTracker, stat_tracker
#   end
#
#   def test_dummy_data_is_initialized
#     stat_tracker = StatTracker.new(@locations)
#
#     assert_equal @locations, stat_tracker.data
#   end
#
#   def test_dummy_data_is_parsed
#     expected = [
#                 ["2012030221",
#                   "20122013",
#                   "Postseason",
#                   "5/16/13",
#                   "3","6","2","3",
#                   "Toyota Stadium",
#                   "/api/v1/venues/null"]
#               ]
#
#     assert_equal expected, CSV.parse("2012030221,20122013,Postseason,5/16/13,3,6,2,3,Toyota Stadium,/api/v1/venues/null")
#   end
#
# end
