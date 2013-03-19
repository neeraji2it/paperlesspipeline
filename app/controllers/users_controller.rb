class UsersController < ApplicationController

  def admin
    @user = current_user
  end
  
  def update
    @user = User.find_by_id(current_user.id)
    if @user.update_attributes(params[:user])
      redirect_to dashboard_index_path
    else
      render(:action => 'admin')
    end
  end
  
  def manage_locations
  end
  
  def manage_users
  end
  
  def add_user
    
  end
end
