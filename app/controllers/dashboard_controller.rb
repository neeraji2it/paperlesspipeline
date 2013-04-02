class DashboardController < ApplicationController
  layout 'application'
  def index
    if current_user.documents.present?
      @documents = Document.where("user_id = #{current_user.id}")
    else
      flash[:notice] = "Please upload documents"
    end
  end
  
  def show
  end
end
