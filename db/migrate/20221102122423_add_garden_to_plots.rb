class AddGardenToPlots < ActiveRecord::Migration[5.2]
  def change
    add_reference :plots, :garden, foreign_key: true
  end
end
