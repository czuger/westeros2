require 'active_record'

# This class contain the house information for a given alliance on a given game board
module Alliances
  class AlHouse < ActiveRecord::Base

    belongs_to :g_game_board
    belongs_to :h_house

  end
end
