class AmenitiesController < ApplicationController

  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    @amenity=Amenity.all
  end

  def new
    @amenity=Amenity.new
  end

 def create
   @amenity=Amenity.new(amenity_params)
   if @amenity.save
     redirect_to amenities_path
   else
     render action: 'new'
   end
 end

 def edit
  @amenity=Amenity.find(params[:id])
 end

 def destroy
   @amenity=Amenity.find(params[:id])
   @amenity.destroy
   redirect_to amenities_path
 end

 def update
   @amenity=Amenity.find(params[:id])
   @amenity.update_attributes(amenity_params)
   if @amenity.save
     redirect_to amenities_path
   else
     render action: 'edit'
 end
end

private

def amenity_params
  params[:amenity].permit(:name, :description)
end
end
