class CreateCCities < ActiveRecord::Migration[5.0]
  def change
    create_table :c_cities do |t|
      t.string :code_name
      t.integer :q
      t.integer :r
      t.references :h_house, foreign_key: true

      t.timestamps
    end
    add_index :c_cities, [ :q, :r ], unique: true
  end
end
