class RoomsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @room = Room.order(price: :desc).paginate(:page => params[:page], per_page:4)
  end

  def authorize
    @room = Room.where(is_authorized: false)
  end

  def myrooms
    @room = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      redirect_to rooms_path
    else
      render action: 'new'
    end
  end

 def edit
  @room = Room.find(params[:id])
 end

 def destroy
  @room = Room.find(params[:id])
  @room.destroy
  redirect_to rooms_path
 end

 def show
  @room = Room.find(params[:id])
  @booking = Booking.new
 end

 def update
  @room = Room.find(params[:id])
  @room.update_attributes(room_params)
  if @room.save
    redirect_to room_path(@room.id)
  else
    render action: 'edit'
  end
 end

 private
 def room_params
  params[:room].permit(:name, :description, :price, :city_id, :address, :rules, :cover, :latitude, :longitude, :is_authorized, amenity_ids:[])
 end

end
