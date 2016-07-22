class AddTypeToGGameBoardToken < ActiveRecord::Migration[5.0]
  def change
    add_column :g_game_board_tokens, :type, :string, null: false
  end
end
