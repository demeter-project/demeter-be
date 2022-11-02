class CreatePlotPlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plot_plants do |t|
      t.references :plot, foreign_key: true
      t.references :plant, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
