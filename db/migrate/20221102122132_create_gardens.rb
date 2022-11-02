class CreateGardens < ActiveRecord::Migration[5.2]
  def change
    create_table :gardens do |t|
      t.string :name
      t.integer :zip_code
      t.string :state_code

      t.timestamps
    end
  end
end
