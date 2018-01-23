class RemoveColumnIsDeliveredToRooms < ActiveRecord::Migration[5.1]
  def change
    remove_column :rooms, :is_delivered
  end
end
