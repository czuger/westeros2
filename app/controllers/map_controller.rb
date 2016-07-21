class MapController < ApplicationController
  def show
    @tokens = @game_board.g_game_board_tokens
  end
end
