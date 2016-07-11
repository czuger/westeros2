# q, r : positions
# pawn type : (hex, round, square)
# Border color : (if different than default)
# Inner color one and 2 (for occupy cities, etc ...)

class GGameBoardPawn < ApplicationRecord
  belongs_to :g_game_board
end
