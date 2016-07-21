class CreateAlliancesAlLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :al_logs do |t|
      t.references :g_game_board, index: true, foreign_key: true, null: false
      t.integer :log_code, null: false
      t.text :alliance_details
      t.integer :turn, null: false

      t.timestamps null: false
    end
  end
end
