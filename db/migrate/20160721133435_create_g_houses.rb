class CreateGHouses < ActiveRecord::Migration[5.0]
  def change
    create_table :g_houses do |t|
      t.references :g_game_board, foreign_key: true
      t.references :h_house, foreign_key: true
      t.boolean :major_house, null: false

      t.timestamps
    end
  end
end
