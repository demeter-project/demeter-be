class CreateNativePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :native_plants do |t|
      t.string :symbol
      t.string :scientific_name
      t.string :common_name
      t.integer :frost_free_days_min
      t.integer :temperature_min
      t.string :edible

      t.timestamps
    end
  end
end
