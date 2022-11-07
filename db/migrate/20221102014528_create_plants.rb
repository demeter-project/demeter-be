class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :usda_symbol
      t.string :scientific_name
      t.string :common_name
      t.string :states
      t.string :flower_color
      t.string :drought_tolerance
      t.string :fire_tolerance
      t.string :moisture_use
      t.string :toxicity
      t.string :duration
      t.string :growth_rate
      t.string :salinity_tolerance
      t.string :shade_tolerance
      t.boolean :edible
      t.decimal :ph_minimum
      t.decimal :ph_maximum
      t.integer :temperature_min
      t.integer :frost_free_days_min
      t.integer :precipitation_min
      t.integer :precipitation_max
    end
  end
end
