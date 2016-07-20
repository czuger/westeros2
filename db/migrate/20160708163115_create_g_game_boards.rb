class CreateGGameBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :g_game_boards do |t|
      t.integer :turn, null: false, default: 1
      t.timestamps
    end
  end
end
