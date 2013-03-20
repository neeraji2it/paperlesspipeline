class LocationsController < ApplicationController
 def update
    @location = Location.new(:location => params[:location][:location],:user_id => current_user.id)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, :notice => 'Location was successfully updated.' }
        format.js
      else
        format.html { render :action => "edit" }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    raise params.inspect
  end
  
end
