class RemoveColumnToUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :role_id
  end
end
