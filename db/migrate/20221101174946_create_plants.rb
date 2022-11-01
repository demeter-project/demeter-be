class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :symbol
      t.string :scientific_name
      t.string :common_name
      t.integer :moisture_use
      t.integer :temperature_min
      t.timestamps
    end
  end
end
