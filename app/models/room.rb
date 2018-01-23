class Room < ApplicationRecord
  belongs_to :city
  belongs_to :user
  has_many   :bookings

  has_many   :amenity_rooms
  has_many   :amenity, through: :amenity_rooms

  validates_presence_of :name, :city_id, :description, :price, :rules, :address, :cover
  validates_length_of   :description, within: 1...1500

  mount_uploader        :cover, CoverUploader

  before_save  :determine_address

  after_save   :guest_to_host

  after_save   :destroy_role_guest_after_become_host

  after_update :check_room_is_authorize

  def determine_address
  response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.address}&key=AIzaSyCLcFfdZgRMVeifvPvdJ9ufhDarWeOxnZ4")
  self.latitude = response["results"][0]["geometry"]["location"]["lat"]
  self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end

  def guest_to_host
    if self.user.role? "guest"
        Permission.create(user_id: user.id, role_id: Role.second.id)
    end
  end

  def destroy_role_guest_after_become_host
    if c = Permission.find_by(user_id: user.id, role_id: Role.last.id)
       c.destroy
    end
  end

  def check_room_is_authorize
    if self.is_authorized == true
      NotificationMailer.authorize_confirmation(self).deliver!
    end
  end
end
