class AddColumnToBooking < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :is_confirmed, :boolean, default: false
  end
end
