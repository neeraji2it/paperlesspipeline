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
    @users = User.all
  end
  
  def add_user
    @user = User.new
  end

  def user_create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'OK!  Please check your email to complete your registration.'
      redirect_to dashboard_index_path
    else
      render :action => 'add_user'
    end
  end
end
