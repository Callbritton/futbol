require_relative './game_data'
require_relative './game_team_data'
require_relative './team_data'
require_relative './game_statistics'
require_relative './league_statistics'
require_relative './season_statistics'
require 'csv'

class StatTracker

  def self.from_csv(data)

    StatTracker.new(data)
  end

  attr_reader :data #For testing. Eventually make a mock/stub so our test can pass without this

  def initialize(data)
    @data = data
  end
end
