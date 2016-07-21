class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_g_game_board_from_game_board_id
    @g_game_board = GGameBoard.find(params[:g_game_board_id])
  end

end
