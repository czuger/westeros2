module Alliances
  class AlAllianceMaster < ApplicationRecord
    belongs_to :g_game_board
    belongs_to :h_house
    belongs_to :h_house_master, class_name: 'HHouse'
  end
end
