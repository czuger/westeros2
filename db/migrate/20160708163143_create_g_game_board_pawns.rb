class CreateGGameBoardPawns < ActiveRecord::Migration[5.0]
  def change
    create_table :g_game_board_pawns do |t|
      t.references :g_game_board, foreign_key: true
      t.integer :q
      t.integer :r
      t.integer :mapple_type
      t.integer :border_color
      t.integer :inner_color_1
      t.integer :inner_color_2

      t.timestamps
    end
    add_index :g_game_board_pawns, [ :id, :q, :r ], unique: true
  end
end
