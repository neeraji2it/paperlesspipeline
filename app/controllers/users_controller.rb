class UsersController < ApplicationController

  def admin
    @user = current_user
  end
  
  def update
    raise params.inspect
  end
  
end
