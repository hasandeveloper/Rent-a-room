class BookingsController < ApplicationController

 def new
  @booking = Booking.new
 end

 def create
   @booking = Booking.new(booking_params)
   @booking.user_id = current_user.id
    if @booking.save
    redirect_to room_path(@booking.room_id), notice: "sucessfully Booked"
  else
    render action: 'new'
    end
 end

  def index
     @booking = current_user.bookings
  end

  def confirmation
    @booking = Booking.where(is_confirmed: false)
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update_attributes(booking_params)
      redirect_to bookings_confirmation_path
    else
      redirect_to bookings_confirmation_path, notice: "Unable to update the booking "
  end
end

 private

 def booking_params
   params[:booking].permit(:start_date, :end_date, :room_id, :user_id, :is_confirmed)
 end

end
