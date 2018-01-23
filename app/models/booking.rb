class Booking < ApplicationRecord

  belongs_to :user
  belongs_to :room

  validates_presence_of :start_date, :end_date, :room_id, :user_id
  validate :check_date
  validate :check_room_dates, on: :create

  after_create :send_mail_to_guest
  after_update :confirm_booking_by_host



  private

  def check_date
    if self.start_date < Date.today
       self.errors.add(:start_date, "Start Date should be greater than todays date")
    end
    if self.end_date < self.start_date
       self.errors.add(:end_date, "End Date should Not greater than Start date")
    end
end

def check_room_dates

  n1 = self.start_date
  n2 = self.end_date

  now_booking = (n1..n2).to_a

  previous_booking = Booking.where('room_id=?', self.room_id)
  previous_booking.each do |prdate|
    n3 = prdate.start_date
    n4 = prdate.end_date

    all_previous_booking = (n3..n4).to_a

    now_booking.each do |date|
      if all_previous_booking.include?(date)
        self.errors.add(:base, "this room is already booked " )
        break
      end

    end
  end

end

  def send_mail_to_guest
    NotificationMailer.succesfully_booked(self).deliver!
  end

  def confirm_booking_by_host
    if is_confirmed == true
      NotificationMailer.booking_confirmation(self).deliver!
  end
end
end
