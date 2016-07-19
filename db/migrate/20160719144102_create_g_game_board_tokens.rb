class CreateGGameBoardTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :g_game_board_tokens do |t|
      t.references :g_game_board, foreign_key: true
      t.integer :q, null: false
      t.integer :r, null: false
      t.integer :top, null: false
      t.integer :left, null: false
      t.string :up_filename, null: false
      t.string :down_filename, null: false
      t.string :hover_data

      t.timestamps
    end
    add_index :g_game_board_tokens, [ :q, :r ], unique: true
  end
end
