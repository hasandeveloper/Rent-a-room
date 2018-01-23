class RemoveColumnFromRoom < ActiveRecord::Migration[5.1]
  def change
    remove_column :rooms, :images
  end
end
