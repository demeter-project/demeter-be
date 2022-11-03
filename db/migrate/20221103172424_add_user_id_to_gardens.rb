class AddUserIdToGardens < ActiveRecord::Migration[5.2]
  def change
    add_column :gardens, :user_id, :bigint
  end
end
