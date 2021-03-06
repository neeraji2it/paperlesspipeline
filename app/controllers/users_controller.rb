class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def admin
    @user = current_user
  end

  def profile
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
    @locations = Location.all
    if request.xhr?
    end
  end
  
  def manage_users
    @users = User.where("create_id = #{current_user.id}")
  end

  def show
    sign_out :user
    redirect_to root_path
  end
  
  def add_user
    @user = User.new
    @roles = Role.all
  end

  def user_create
    @user = User.new(params[:user])
    if @user.save
      redirect_to dashboard_index_path
      flash[:notice] = 'OK!  Please check your email to complete your registration.'
    else
      render :action => 'add_user'
    end
  end

  def activate
    @user = User.find(params[:id])
    if params[:active] == 'Active'
      @user.update_attributes({
          :confirmation_token => "M5ysQarV6KCK5nxz67xu",
          :confirmed_at => "",
          :active => "Deactive"
        })
    elsif params[:active] == 'Deactive'
      @user.update_attributes({
          :confirmation_token => nil,
          :confirmed_at => Time.now,
          :active => "Active"
        })
    end
    redirect_to manage_users_user_path(current_user)
  end

  def add_role
    @role = Role.new(params[:role])
    @user = User.new
    if @role.save
      render
    end
  end
end
