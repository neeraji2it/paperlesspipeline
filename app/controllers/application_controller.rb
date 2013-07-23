class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :after_sign_in_path_for
  layout :layout
  
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      dashboard_index_path
    end
  end

  def logged_in_user
    unless current_user
      redirect_to root_path
    end
  end
  
  def is_valid_account?
    if current_user and current_user.documents.present? and (["sale", "private", "listing"]-current_user.documents.map{|a| a.document_type}.uniq).blank? == false
      redirect_to dashboard_index_path
    end
  end

  def layout
    (is_a?(Devise::SessionsController) || is_a?(Devise::RegistrationsController)) ? false : "application"
    # or turn layout off for every devise controller:
  end
  
  def is_signed_in?
    unless current_user
      flash[:notice] = "Please Relogin to Continue"
      redirect_to root_path
    end
  end


end
