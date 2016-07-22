class AddExtraParametersToGGameBoardToken < ActiveRecord::Migration[5.0]
  def change
    add_column :g_game_board_tokens, :extra_parameters, :string
  end
end
