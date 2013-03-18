class DashboardController < ApplicationController
  def index
    @documents = Document.where("user_id = #{current_user.id}")
  end
  
  def show
  end
end
