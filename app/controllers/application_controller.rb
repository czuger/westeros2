class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_current_game_board

  def set_current_game_board
    @game_board = GGameBoard.first
  end

end
