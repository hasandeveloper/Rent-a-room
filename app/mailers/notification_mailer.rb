class NotificationMailer < ApplicationMailer

  def authorize_confirmation(room)
    @room = room
    mail to: "#{room.user.email}", subject: "Your booking has been authorized"
  end

  def succesfully_booked(booking)
    @booking = booking
    mail to: "#{booking.user.email}", subject: "Your Room Has booked"
  end

  def booking_confirmation(booking)
    @booking = booking
    mail to: "#{booking.user.email}", subject: "Your Booking has been confirmed"
  end



end
