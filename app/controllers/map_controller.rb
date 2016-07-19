class MapController < ApplicationController
  def show
    @tokens = GGameBoard.first.g_game_board_tokens
  end
end
