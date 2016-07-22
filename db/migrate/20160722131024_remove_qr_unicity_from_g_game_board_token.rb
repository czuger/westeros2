class RemoveQrUnicityFromGGameBoardToken < ActiveRecord::Migration[5.0]
  def change
    remove_index :g_game_board_tokens, [ :q, :r ]
  end
end
