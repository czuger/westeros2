module Armies
  class GArmy < ApplicationRecord
    belongs_to :g_game_board
    belongs_to :h_house
  end
end