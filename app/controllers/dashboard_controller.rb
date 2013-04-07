class DashboardController < ApplicationController
  layout 'application'
  def index
      @documents = Document.where("user_id = #{current_user.id}")
  end
  
  def show
  end
end
