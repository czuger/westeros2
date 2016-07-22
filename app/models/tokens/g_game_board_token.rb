module Tokens
  class GGameBoardToken < ApplicationRecord
    belongs_to :g_game_board

    serialize :extra_parameters

    def extra_params
      {}
    end

  end
end
