class CreateAlAllianceMasters < ActiveRecord::Migration[5.0]
  def change
    create_table :al_alliance_masters do |t|
      t.references :g_game_board, foreign_key: true, null: false
      t.references :h_house, foreign_key: true, null: false
      t.references :h_house_master, null: false

      t.timestamps
    end
    add_foreign_key :al_alliance_masters, :h_houses, column: :h_house_master_id
    add_index :al_alliance_masters, [ :g_game_board_id, :h_house_id ], unique: true
  end
end
