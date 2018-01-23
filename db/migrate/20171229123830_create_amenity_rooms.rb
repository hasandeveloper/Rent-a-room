class CreateAmenityRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :amenity_rooms do |t|
      t.integer :room_id
      t.integer :amenity_id

      t.timestamps
    end
  end
end
