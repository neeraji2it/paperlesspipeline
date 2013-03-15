class DashboardController < ApplicationController
  def index
  end
  
  def show
  end

  
  def add_name1
    @add_name = IntakeForm.find(params[:id])
    if params[:name].blank?
    else
      @user = User.find(params[:name])
      CaseIntakeform.create(:name =>@user.name,:user_id => @user.id)
    end
    render
  end
end
