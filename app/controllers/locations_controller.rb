class LocationsController < ApplicationController
 def update
    @location = Location.new(:name => params[:location][:name],:user_id => current_user.id)

    respond_to do |format|
      if @location.save
#        format.html { redirect_to manage_locations_user_path(current_user), :notice => 'Location was successfully updated.' }
        format.js
        @locations = Location.all
      else
        format.html { render :action => "edit" }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to manage_locations_user_path
    flash[:notice] = "Location deleted"
  end
  
end
