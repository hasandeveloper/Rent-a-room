class AddColumnIsAuthorizedToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :is_delivered, :boolean, default: false
  end
end
