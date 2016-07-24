class CreateGArmies < ActiveRecord::Migration[5.0]
  def change
    create_table :g_armies do |t|
      t.references :g_game_board, foreign_key: true
      t.references :h_house, foreign_key: true
      t.string :type
      t.string :code_name
      t.integer :q
      t.integer :r
      t.integer :nb_banners

      t.timestamps
    end
    add_index :g_armies, :type
    add_index :g_armies, [ :g_game_board_id, :q, :r ], unique: true
  end
end
