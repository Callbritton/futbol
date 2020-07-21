require './lib/instantiable'
include Instantiable
require "minitest/autorun"
require "minitest/pride"


class ClassTest < Minitest::Test

  def test_instances_of_game
    game_data = Instantiable.create_instances_of_game

    assert_equal 19, game_data.size
  end

  def test_instances_of_team
    team_data = Instantiable.create_instances_of_team

    assert_equal 19, team_data.size
  end

  def test_instances_of_team_game
    team_game_data = Instantiable.create_instances_of_team_game

    assert_equal 19, team_game_data.size
  end
end
