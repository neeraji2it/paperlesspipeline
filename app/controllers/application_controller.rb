class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :after_sign_in_path_for
  
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      dashboard_index_path
    end
  end
  
  def is_valid_account?
    if current_user and current_user.documents.present? and (["sale", "private", "listing"]-current_user.documents.map{|a| a.document_type}.uniq).blank? == false
      redirect_to dashboard_index_path
    end
  end
  
end
