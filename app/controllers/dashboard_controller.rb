class DashboardController < ApplicationController
  def index
  end
  def show
  end
  
  def password_details
    
  end

  def change_password
    current_user.errors.add(:password, "is required") if params[:user].nil? or params[:user][:password].to_s.blank?
    if current_user.errors.empty? and current_user.update_with_password(params[:user])
      sign_in(:user, current_user, :bypass => true)
      flash.now[:notice] = 'Your password changed successfully.'
    else
      flash.now[:alert] = 'Password changing failed.'
    end
    render :action => "show"
  end
  
end
